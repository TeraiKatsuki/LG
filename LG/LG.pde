
int cell[];        //Curent cell.
int ncell[];       //Next cell.
int cellsize = 20; //Cell draw rect size.
int cwidth = 40;   //Cell width.
int cheight = 40;  //Cell height.
int size = cwidth * cheight;  //Cell array size.

int life = 0; 
int death = 1;
int set =2;
boolean issetmode =true;

//setup.
void setup()
{
   cell = new int[size];
   ncell = new int[size];
   for(int i=0; i<size;i++)
   {
     cell[i] = death; 
     ncell[i] = death;
   }
   //setCellAsRandom();
   //setCellAsMonolith();
   size(800,800);  
   frameRate(60);  
}

//set cell as random.
void setCellAsRandom()
{
   for(int i=0; i<size;i++)
   {
     if(random(10) < 5)
     {
        cell[i] = life;  
     }else
     {
       cell[i] = death;
     }
     
   }
}

//set monolith.
void setCellAsMonolith()
{
  cell[0] = life;
  cell[1] = life;
  cell[cwidth] = life;
  cell[cwidth+1] = life;
}

//Set key down.
void setSellAsMouseCick(float x,float y)
{
   int rw =0;   //rect width.
   int rh=-20;  //rect height.
   
  for(int i=0; i<cheight; i++){
     rh+=cellsize;
     rw=0;
      for(int j=0; j<cwidth;j++){
        if(rw < x && rw +cellsize > x && rh < y && rh +cellsize > y){
          int c = cell[i * cwidth + j];
          
        if(c == life) cell[i * cwidth + j] = death;
        else if(c==death) cell[i * cwidth + j] = life;
        
        }
        rw+=cellsize;
      }
   }
}

//Reset.
void Reset()
{
   for(int i=0; i<size;i++)
   {
     cell[i] = death; 
     ncell[i] = death;
   }
   issetmode=true;
}

//Mouse pressed event.
void mousePressed() {
  if(issetmode){
     setSellAsMouseCick(mouseX,mouseY);
  }
}

//Key pressed event.
void keyPressed() {
  if (keyCode == ENTER) {
    issetmode=false;
  }else if(key == 'r'){
     Reset();
  }
}

//draw.
void draw()
{
   background(255);
   if(!issetmode){
      updatecell();
      drawcell();
   }else{
     drawcell();
   }
  
}

//update cell.
void updatecell()
{
  for(int i=0; i<cheight; i++)
   {
      for(int j=0; j<cwidth;j++)
      {
        int center = i * cwidth + j;
        int top = (i-1) * cwidth + j;
        int under = (i+1) * cwidth + j;
        int left =  i * cwidth + (j-1);
        int right = i * cwidth + (j+1);
        int rightup = top +1;
        int leftup =  top-1;
        int rightdown = under+1;
        int leftdown =  under-1;
        int carray[] = {top,under,left,right,rightup,leftup,rightdown,leftdown};
        boolean isjudge=false;
        int lc=0; //Life count.
        
        //Check special array patterns.
        if(center != 0 && center / cwidth ==0){
          right=-1;
          rightup=-1;
        }
        if(center -1 / cwidth ==0){
          left=-1;
          leftup=-1;
        }
        
        
        for(int k =0; k < 8; k++){
           int c = carray[k];
           if(c >=0 && c<size){
              isjudge=true;
              int state = cell[c];
              if(state == life) lc++;
           }
        }
        
        if(isjudge){
          if(cell[center] == death && lc==3) ncell[center] = life;
          else if(cell[center] == life && lc ==2) ncell[center] = life;
          else if(cell[center] == life && lc ==3) ncell[center] = life;
          else ncell[center] = death;
        }
        
      }  
   }
   
   //Copy.
   for(int i=0; i<size;i++){
     cell[i] = ncell[i];
   }
   
}

//draw cell.
void drawcell()
{
   int rw =0;   //rect width.
   int rh=-cellsize;  //rect height.
   
   for(int i=0; i<cheight; i++)
   {
      rh+=cellsize;
      rw=0;
      for(int j=0; j<cwidth;j++)
      {
        int c = cell[i * cwidth + j];
        if(c == life) fill(0);
        else if(c==death) fill(255);
        else println("Error");
        rect(rw,rh,rw +20,rh+20);
        rw+=cellsize;
      }
      
   }
   
}