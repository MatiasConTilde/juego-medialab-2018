/* 
 *              weupnp - Trivial upnp java library 
 *
 * Copyright (C) 2008 Alessandro Bahgat Shehata, Daniele Castagna
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, FΩifth Floor, Boston, MA  02110-1301  USA
 * 
 * Alessandro Bahgat Shehata - ale dot bahgat at gmail dot com
 * Daniele Castagna - daniele dot castagna at gmail dot com
 * 
 */

/*
 * refer to miniupnpc-1.0-RC8
 */
//wrapper by Pablo Fernández Robledo
//TODO: put library in code folder!
import org.bitlet.weupnp.*;

import java.net.InetAddress;
import java.text.DateFormat;
import java.util.Date;
import java.util.Map;

class Upnp {
  private int PORT = 6991;
  private boolean LIST_ALL_MAPPINGS = false;

  GatewayDiscover gatewayDiscover;
  PortMappingEntry portMapping;
  GatewayDevice activeGW;

  Upnp (int port, boolean force) {
    PORT = port;
    try {
      addLogLine("Starting weupnp");

      gatewayDiscover = new GatewayDiscover();
      addLogLine("Looking for Gateway Devices...");

      Map<InetAddress, GatewayDevice> gateways = gatewayDiscover.discover();

      if (gateways.isEmpty()) {
        addLogLine("No gateways found");
        addLogLine("Stopping weupnp");
        return;
      }
      addLogLine(gateways.size()+" gateway(s) found\n");

      int counter=0;
      for (GatewayDevice gw : gateways.values()) {
        counter++;
        addLogLine("Listing gateway details of device #" + counter+
          "\n\tFriendly name: " + gw.getFriendlyName()+
          "\n\tPresentation URL: " + gw.getPresentationURL()+
          "\n\tModel name: " + gw.getModelName()+
          "\n\tModel number: " + gw.getModelNumber()+
          "\n\tLocal interface address: " + gw.getLocalAddress().getHostAddress()+"\n");
      }

      // choose the first active gateway for the tests
      activeGW = gatewayDiscover.getValidGateway();
      if (null != activeGW) {
        addLogLine("Using gateway: " + activeGW.getFriendlyName());
      } else {
        addLogLine("No active gateway device found");
        addLogLine("Stopping weupnp");
        return;
      }

      // testing PortMappingNumberOfEntries
      Integer portMapCount = activeGW.getPortMappingNumberOfEntries();
      addLogLine("GetPortMappingNumberOfEntries: " + (portMapCount!=null?portMapCount.toString():"(unsupported)"));

      // testing getGenericPortMappingEntry
      portMapping = new PortMappingEntry();
      if (LIST_ALL_MAPPINGS) {
        int pmCount = 0;
        do {
          if (activeGW.getGenericPortMappingEntry(pmCount, portMapping))
            addLogLine("Portmapping #"+pmCount+" successfully retrieved ("+portMapping.getPortMappingDescription()+":"+portMapping.getExternalPort()+")");
          else {
            addLogLine("Portmapping #"+pmCount+" retrieval failed"); 
            break;
          }
          pmCount++;
        } while (portMapping!=null);
      } else {
        if (activeGW.getGenericPortMappingEntry(0, portMapping))
          addLogLine("Portmapping #0 successfully retrieved ("+portMapping.getPortMappingDescription()+":"+portMapping.getExternalPort()+")");
        else
          addLogLine("Portmapping #0 retrival failed");
      }

      InetAddress localAddress = activeGW.getLocalAddress();
      addLogLine("Using local address: "+ localAddress.getHostAddress());
      String externalIPAddress = activeGW.getExternalIPAddress();
      addLogLine("External address: "+ externalIPAddress);

      addLogLine("Querying device to see if a port mapping already exists for port "+ PORT);

      if (activeGW.getSpecificPortMappingEntry(PORT, "TCP", portMapping)) {
        ////
        if (force) {
          addLogLine("Port "+PORT+" is already mapped. Atemting to free port.");
          if (this.free()) {
            addLogLine("Port freed. Sending port mapping request for port "+PORT);
            if (activeGW.addPortMapping(PORT, PORT, localAddress.getHostAddress(), "TCP", "test")) {
              addLogLine("Mapping SUCCESSFUL");
            }
          } else {
            addLogLine("Failed freeing Port, "+PORT+" is already mapped. Aborting test.");
            return;
          }
        } else {
          ////
          addLogLine("Port "+PORT+" is already mapped. Aborting test.");
          return;
        }
      } else {
        addLogLine("Mapping free. Sending port mapping request for port "+PORT);

        // test static lease duration mapping
        if (activeGW.addPortMapping(PORT, PORT, localAddress.getHostAddress(), "TCP", "test")) {
          addLogLine("Mapping SUCCESSFUL");
        }
        //if (activeGW.addPortMapping(PORT, PORT, localAddress.getHostAddress(), "TCP", "test")) {
        //  addLogLine("Mapping SUCCESSFUL. Waiting "+WAIT_TIME+" seconds before removing mapping...");
        //  Thread.sleep(1000*WAIT_TIME);
        //}
      }
    }
    catch (Exception e) {
      addLogLine("Problem initializing Upnp");
      println(e);
    }
  }

  Upnp (int port) {
    this(port, false);
  }

  boolean free() {
    try {
      if (activeGW.deletePortMapping(PORT, "TCP")) {
        addLogLine("Port mapping removed, SUCCESSFUL");
        return true;
      } else {
        addLogLine("Port mapping removal FAILED");
        return false;
      }
    }
    catch(Exception e) {
      addLogLine("Exception in delete function (Upnp)");
      return false;
    }
  }

  private void addLogLine(String line) {
    String timeStamp = DateFormat.getTimeInstance().format(new Date());
    String logline = timeStamp+": "+line+"\n";
    print(logline);
  }

  String getLocalAddress() {
    try {
      return activeGW.getLocalAddress().getHostAddress();
    }
    catch(Exception e) {
      addLogLine("Exception getting Local Address (Upnp)");
      return null;
    }
  }

  String getExternalIP() {
    try {
      return activeGW.getExternalIPAddress();
    }
    catch(Exception e) {
      addLogLine("Exception getting External IP Address (Upnp)");
      return null;
    }
  }

  int getPort() {
    return PORT;
  }
}
