int clicked_x;
int clicked_y;



int mid_x;
int mid_y;
float distance;
float start_a;
float end_a;

int x;
String fill_num;

int[] points = new int[8];
String[] fillArr = new String[9];


boolean clicking;
boolean clicking1;

boolean quad;
boolean circ;
boolean arc;
boolean line;
boolean tri;
boolean erase;

boolean fir_click;
boolean sec_click;
boolean thi_click;

void setup()
{
  fullScreen();
  background(255);
  fillArr[0] = "0";
  fillArr[1] = "0";
  fillArr[2] = "0";
  fillArr[3] = "0";
  fillArr[4] = "0";
  fillArr[5] = "0";
  fillArr[6] = "0";
  fillArr[7] = "0";
  fillArr[8] = "0";
}

void draw()
{
   textSize(20);
   if(erase == true)
   {
     fill(255,255,255);
     rect(0,0,width,height);
   }
   
   fill(0);
   rect(width-50,0,50,50);
   fill(255);
   text("Q",width-20,25);
   
   fill(0);
   rect(width-50,60,50,50);
   fill(255);
   text("C",width-20,85);
   
   fill(0);
   rect(width-50,120,50,50);
   fill(255);
   text("A",width-20,145);
   
   fill(0);
   rect(width-50,180,50,50);
   fill(255);
   text("L",width-20,205);
   
   fill(0);
   rect(width-50,240,50,50);
   fill(255);
   text("T",width-20,265);
   
   fill(0);
   rect(width-50,300,50,50);
   fill(255);
   text("E",width-20,325);
   
   fill(0);
   text("Fill: ",width/100,15);
   for(int x = 0;x<3;x++)
   {
     fill(0);
     rect((width/100+35)*(x+1),0,33,20);
     fill(255);
     text(fillArr[3*(x)],(width/100+35)*(x+1),15);
     text(fillArr[(1)+3*(x)],(width/100+35)*(x+1)+10,15);
     text(fillArr[(2)+3*(x)],(width/100+35)*(x+1)+20,15);
   }
   
   if(int(fillArr[0]+fillArr[1]+fillArr[2])>255)
   {
     fill(255,int(fillArr[3]+fillArr[4]+fillArr[5]),int(fillArr[6]+fillArr[7]+fillArr[8]));
   }
   else if(int(fillArr[3]+fillArr[4]+fillArr[5])>255)
   {
     fill(int(fillArr[0]+fillArr[1]+fillArr[2]),255,int(fillArr[6]+fillArr[7]+fillArr[8]));
   }
   else if(int(fillArr[6]+fillArr[7]+fillArr[8])>255)
   {
     fill(int(fillArr[0]+fillArr[1]+fillArr[2]),int(fillArr[3]+fillArr[4]+fillArr[5]),255);
   }
   else
   {
     fill(int(fillArr[0]+fillArr[1]+fillArr[2]),int(fillArr[3]+fillArr[4]+fillArr[5]),int(fillArr[6]+fillArr[7]+fillArr[8]));
   }
   
   if(quad == true)
   {
     if(x == 8)
     {
       quad(points[0],points[1],points[2],points[3],points[6],points[7],points[4],points[5]);
       x=0;
     }
     if(clicking==true)
     {
       point(clicked_x, clicked_y);
       points[x++] = clicked_x;
       points[x++] = clicked_y;
       clicking = false;
     }
   }
   else if(circ == true)
   {
     if(x == 4)
     {
       circle((points[0]+points[2])/2,(points[1]+points[3])/2,sqrt(sq(points[2]-points[0])+sq(points[1]-points[3])));
       x=0;
     }
     if(clicking==true)
     {
       point(clicked_x, clicked_y);
       points[x++] = clicked_x;
       points[x++] = clicked_y;
       clicking = false;
     }
   }
   else if(arc == true)
   {
     if(x == 4)
     {
       mid_x = (points[0]+points[2])/2;
       mid_y = (points[1]+points[3])/2;
       distance = sqrt(sq(points[2]-points[0])+sq(points[1]-points[3]));
       start_a = (180/PI*atan2(points[1]-mid_y,points[0]-mid_x));
       end_a = (180/PI*atan2(points[3]-mid_y,points[2]-mid_x));
       if(radians(start_a)>=radians(end_a))
       {
         arc(mid_x,mid_y,distance,distance,radians(end_a),radians(start_a),CHORD);
       }
       else
       {
         arc(mid_x,mid_y,distance,distance,radians(start_a),radians(end_a),CHORD);
       }
       println("arcDrawn "+radians(start_a)+" "+radians(end_a));
       x=0;
     }
     if(clicking==true)
     {
       point(clicked_x, clicked_y);
       points[x++] = clicked_x;
       points[x++] = clicked_y;
       clicking = false;
     }
   }
   else if(line == true)
   {
     if(mousePressed)
     {
       line(mouseX,mouseY,pmouseX,pmouseY);
     }
     if(clicking==true)
     {
       clicking = false;
     }
   }
   else if(tri == true)
   {
     if(x == 6)
     {
       triangle(points[0],points[1],points[2],points[3],points[4],points[5]);
       x=0;
     }
     if(clicking==true)
     {
       point(clicked_x, clicked_y);
       points[x++] = clicked_x;
       points[x++] = clicked_y;
       clicking = false;
     }
   }
}

void mousePressed()
{
  clicked_x = mouseX;
  clicked_y = mouseY;
  for(int x = 0;x<3;x++)
  {
    if(quadContains((width/100+35)*(x+1),0,33,20,mouseX,mouseY))
    {
      if(x == 0)
      {
        fir_click = true;
        sec_click = false;
        thi_click = false;
      }
      if(x == 1)
      {
        fir_click = false;
        sec_click = true;
        thi_click = false;
      }
      if(x == 2)
      {
        fir_click = false;
        sec_click = false;
        thi_click = true;
      }
      clicking1 = true;
    }
  }
  if(mouseX>=width-50&&mouseY<=50)
  {
    //println(clicking+" "+clicking1);
    quad = true;
    circ = false;
    arc = false;
    line = false;
    tri = false;
    erase = false;
  }
  else if(mouseX>=width-50&&mouseY>=60&&mouseY<=110)
  {
    circ = true;
    quad = false;
    arc = false;
    line = false;
    tri = false;
    erase = false;
  }
  else if(mouseX>=width-50&&mouseY>=120&&mouseY<=170)
  {
    arc = true;
    circ = false;
    quad = false;
    line = false;
    tri = false;
    erase = false;
  }
  else if(mouseX>=width-50&&mouseY>=180&&mouseY<=230)
  {
    line = true;
    circ = false;
    quad = false;
    arc = false;
    tri = false;
    erase = false;
  }
  else if(mouseX>=width-50&&mouseY>=240&&mouseY<=290)
  {
    tri = true;
    line = false;
    circ = false;
    quad = false;
    arc = false;
    erase = false;
  }
  else if(mouseX>=width-50&&mouseY>=300&&mouseY<=360)
  {
    erase = true;
    tri = false;
    line = false;
    circ = false;
    quad = false;
    arc = false;
  }
  else if(clicking1 == true)
  {
    clicking1 = false;
  }
  else
  {
    clicking = true;
  }
}

void keyTyped()
{
  if(fir_click == true)
  {
   fillArr[0] = fillArr[1];
   fillArr[1] = fillArr[2];
   fillArr[2] = key+"";
  }
  else if(sec_click == true)
  {
   fillArr[3] = fillArr[4];
   fillArr[4] = fillArr[5];
   fillArr[5] = key+""; 
  }
  else if(thi_click == true)
  {
   fillArr[6] = fillArr[7];
   fillArr[7] = fillArr[8];
   fillArr[8] = key+""; 
  }
}

Boolean quadContains(int quad_x1, int quad_y1, int w, int h, int p_x, int p_y)
{
  if((p_x>=quad_x1&&p_x<=quad_x1+w)&&(p_y>=quad_y1&&p_y<=quad_y1+h))
  {
    return true;
  }
  return false;
}
