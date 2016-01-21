public class block
{
  int key;
  //PFont f;
  int fill;
  int xCoord;
  int yCoord;
  int hue;
  public block(int c,int lol)
  {
    key = c;
    fill = lol;
    //f = createFont("Arial",16,true); // STEP 2 Create Font
    xCoord = 0;
    yCoord = 0;
    hue=#000000;
    if(key==1)
    {
     hue=#A3E39E; 
    }
    if(key==2)
    {
      hue=#DE1010;
    }
    if(key==3)
    {
      hue=#8FD6F0;
    }
    if(key==4)
    {
     hue=#E3F74D; 
    }
    if(key==5)
    {
     hue=#E552FC; 
    }
    if(key==6)
    {
     hue=#52F8FC;
    }
    if(key==7)
    {
      hue=#FC7752;
    }
    if(key==8)
    {
     hue= #6752FC;
    }
    if(key==9)
    {
      hue=#4EB227;
    }
    if(key==0)
    {
      hue=#FC1FE3;
    }
  }
  
  public void create(int y)
  {                                                                                     
    
    if (key == 0)
    {
     xCoord = 9*width/10+65; 
    }
    else
    {
      xCoord=((key-1))*width/10+65;
    }
    yCoord = y;
    
    
    
    if (fill%30==0)
    {
      fill(hue);
      ellipse(xCoord,y,60,60);
    }
    else
    {
      //fill(#000000);
//      noStroke();
     // ellipse(xCoord,y,60,60);
    }
    
  }
}