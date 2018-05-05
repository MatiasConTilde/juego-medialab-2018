class Lifes{
 int lifes; 
 
 Lifes(int l){
   lifes = l;
 }
 
 void display(){
   for(int i=0; i<lifes; i++){
     pushMatrix();
       translate(i*100-100, -200, -500);
       sphere(50);
     popMatrix();
   }
 }
  
  
}
