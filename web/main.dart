import 'dart:html';

ElementList<DivElement> drawDivs;

void main() {
  drawDivs = querySelectorAll('div.drawDiv');
  drawDivs.forEach((input) => drawArc(input));
}


void drawArc(DivElement div) {
  var index = drawDivs.indexOf(div) + 1;

// new canvas path
  CanvasElement canvasPath = new CanvasElement(width: 500, height: 400);
  CanvasRenderingContext2D canvasCtx = canvasPath.getContext('2d');;
  div.append(canvasPath);
  

  List<double> clickPositions = new List();
  // mouse down+mouve
  var moveListener;
  div.onMouseDown.listen((MouseEvent e) {
    e.preventDefault();
    moveListener = div.onMouseMove.listen((MouseEvent e) {
      e.preventDefault();

      clickPositions.add(e.page.x - div.offsetLeft);
      clickPositions.add(e.page.y - div.offset.top);

      print('$index :  $clickPositions');

      if (clickPositions.length == 4) {
        canvasCtx.lineWidth = 2;
        canvasCtx.beginPath();
        canvasCtx.moveTo(clickPositions[0], clickPositions[1]);
        canvasCtx.lineTo(clickPositions[2], clickPositions[3]);
        canvasCtx.stroke();

        // save only the last position
        clickPositions.removeAt(0);
        clickPositions.removeAt(0);
      } else {
//    canvasCtx.clearRect(0, 0, 200, 200);
      }
    });
  });
  div.onMouseUp.listen((MouseEvent e) {
    e.preventDefault();
    moveListener.cancel();
    clickPositions.clear();
  });
}
