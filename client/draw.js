function fill(hue, saturation = 75, lightness = 50) {
  ctx.fillStyle = `hsl(${hue},${saturation}%,${lightness}%)`;
}

function background(lightness) {
  fill(0, 0, lightness);
  ctx.fillRect(0, 0, canvas.width, canvas.height);
}

function rect(x, y, w, h) {
  ctx.fillRect(x - (w / 2), y - (h / 2), w, h);
}

function circle(x, y, r) {
  ctx.beginPath();
  ctx.arc(x, y, r, 0, 2 * Math.PI);
  ctx.fill();
  ctx.stroke();
}
