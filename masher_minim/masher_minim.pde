import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


import java.util.*;

Minim minim;
AudioPlayer player;
AudioInput input;
AudioMetaData meta;

PImage img;

PFont f; 

boolean keyz[] = new boolean [10];

block notes[][]=new block[10][]; //10 for the 10 keys, second level represents the time of the blocks

int paused = 0;

int score=0;
void setup()
{
  img = loadImage("gameover.png");
  
  fullScreen();
  frameRate(100);
  
  minim = new Minim(this);
  player = minim.loadFile("glorious.mp3");
  meta = player.getMetaData();
  player.play();
  
 f = createFont("Arial",16,true);
  
  //size(1400,700);
  background(#000000);
  for(int i=0;i<10;i++)
  {
    fill(#64629B,127);
    rect(0+i*width/10,height-160,width/10,20);
    fill(#F2FAFA);                        
    text((i+1)%10,i*140+65,height-160+15);
  }
  
   Random randgen = new Random(100);
  for(int i =0;i<notes.length;i++)
  {
    notes[i]=new block[(int)(meta.length()/250)];
    for(int j=0;j<notes[i].length;j++)
    {
      notes[i][j] = new block(i,randgen.nextInt());
    }    
  }
  println(meta.length());
  
}

int j = 0;
int y = 0;
int count;

void draw()
{
  count++;
  //background(0);
  loadScore(width-28,20);
  //translate(0,10);
  if (j<notes[0].length)
       {
   
       for(int k=0;k<=j;k++)
       {
         for(int i=0;i<notes.length;i++)
         {
            notes[i][k].create(y-k*60);
         }
         
            
       }
         for(int k=j;k>=0;k--)
         {
            notes[0][k].create(y-k*60);           
         }
      
       j++;
       
       if(notes[0][notes[0].length-1].yCoord >= height+60 || !player.isPlaying())
       {
        player.close();
        clear();
        loadGameOver();
        //text("GAME OVER",700,350);
       }
       else
       {
         
         for(int i=0;i<10;i++)
          {
            fill(#64629B,127);
            
            if(keyPressed && (key >= '0' && key <= '9') && Integer.parseInt(key+"") == i)
            {
              fill(#F2FAFA);
              if(key=='0')
              {
                rect(0+9*width/10,height-160,width/10,20);
              }
              else
              {
               rect(0+(i-1)*width/10,height-160,width/10,20); 
              }
  
              fill(#F2FAFA);                        
              text((i+1)%10,i*width/10+65,height-160+15);              
            }
            else
            {
              rect(0+i*width/10,height-160,width/10,20);
  
              fill(#F2FAFA);                        
              text((i+1)%10,i*width/10+65,height-160+15);
            }
          } 
       }
       
         y+=5;
     }
     else
     {
       j=notes[0].length-1;
       //println("end");
       //clear();
     }
      
      
       
       //delay(delay);
       
       
       
}

boolean track(int i,int j)
{
  if (notes[i][j].yCoord>= height-160-60 && notes[i][j].yCoord<= height-160+60)
  { 
    return true;
  }
  
  return false;
}

void keyPressed()
{
 //for(int i = 0;i<notes.length;i++)
 //{
   if((int)key==32)
   {
    paused++;
    if(paused%2!=0)
    {
     //textFont(f,16);                  // STEP 3 Specify font to be used
     //fill(#FFFFFF);
     //text("PAUSED",width/2,height/2);
     player.pause();
     noLoop(); 
    }
    else
    {
      clear();
      player.play();
     loop(); 
    }
   }
   
   if(key >= '0' && key <= '9')
   {
     int keyInt=Integer.parseInt(key+"");
     for(int j=0;j<notes[keyInt].length;j++)
      {
       if(key == Integer.toString(notes[keyInt][j].key).charAt(0) && track(keyInt,j))
       {  
         notes[keyInt][j].hue = 0;//#FFFFFF;
         score++;
         break;
       }
      }
   }
  
 //}
}


void loadGameOver()
{
    image(img, 0, 0,width,height);
    text("SCORE: "+(score-notes[0].length),width/2,height-160);
}

void loadScore(int x,int y)
{
  //background(0);
   fill(0);    // black rectangle = background for information
  //noStroke();
  rect(width-30,0, 20, 20);
  fill(#FFFFFF);  // Text
  
  text(""+(score-notes[0].length),x,y);
}