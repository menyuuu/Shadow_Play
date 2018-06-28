class Visitor
{
  public FilePlayer player1;
  String[] sampleList;

  AudioOutput output;
  LowPassFS   lpf;

  // constructor
  Visitor(String[] sl)
  {
    sampleList = sl;

    output = minim.getLineOut();
    player1 = new FilePlayer (minim.loadFileStream(sampleList[0])); 
    lpf = new LowPassFS(100, output.sampleRate());
    player1.patch( lpf ).patch( output );
  }


  void handpinch(float handPinch)
  {

    float handPinchInvert= map(1-handPinch, 0, 1, 0, 1);
    float cutoff = map(handPinchInvert, 0, 1, 60, 2000); //0,1,60,2000
    lpf.setFreq(cutoff);

    if (handPinch<=0.85 && handToggle == false) //0.99
    { 
      println("hand open");
      player1.play();
      handToggle = true;
    }

    if (handPinch>0.90 && handToggle == true) 
    {
      player1.pause();
      player1.rewind();
      count++;
      if (count>=3) //nr. of files
      { 
        count = 0;
      }
      player1 = new FilePlayer (minim.loadFileStream(sampleList[count]));  
      player1.patch( lpf ).patch( output );
      handToggle = false;
      println("hand closed");
    }
  }


  // void draw()
  // {
  //   for ( int i = 0; i < output.bufferSize() - 1; i++ )
  //   {
  //     float x1 = map(i, 0, output.bufferSize(), 0, width);
  //     float x2 = map(i+1, 0, output.bufferSize(), 0, width);
  //     line(x1, height/4 - output.left.get(i)*50, x2, height/4 - output.left.get(i+1)*50);
  //     //line(x1, 3*height/4 - output.right.get(i)*50, x2, 3*height/4 - output.right.get(i+1)*50);
  //   }
  // }
}
