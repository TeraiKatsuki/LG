
int cell[];
int cwidth = 40;
int cheight = 40;
int size = cwidth * cheight;

int life = 0;
int death = 1;
int set =2;

//setup.
void setup()
{
   cell = new int[size];
   for(int i=0; i<size;i++)
   {
     cell[i] = death; 
   }
   setCellAsRandom();
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

//draw.
void draw()
{
   background(255);
   updatecell();
   drawcell();
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
        int left =  i * cwidth + j-1;
        int right = i * cwidth + j+1;
        int rightup = (i-1) * cwidth + (j+1);
        int leftup =  (i-1) * cwidth + (j-1);
        int rightdown = (i+1) * cwidth + (j+1);
        int leftdown =   (i+1) * cwidth +(j-1);
        int carray[] = {top,under,left,right,rightup,leftup,rightdown,leftdown};
        boolean isjudge=false;
        int lifecount=0;
        int deathcount=0;
        
        for(int k =0; k < 8; k++){
           int c = carray[k];
           if(c >=0 && c<size){
              isjudge=true;
              int state = cell[c];
              if(state == life) lifecount++;
              else if(state ==death) deathcount++;
           }
        }
        
        if(isjudge){
          if(cell[center] == death && lifecount==3) cell[center] = life;
          else if(cell[center] == life && lifecount <=1) cell[center] = death;
          else if(cell[center] == life && lifecount >=4) cell[center] = death;
        }
        
      }  
   }
   
}

//draw cell.
void drawcell()
{
   int rw =0; //rect width.
   int rh=-20;  //rect height.
   
   for(int i=0; i<cheight; i++)
   {
      rh+=20;
      rw=0;
      for(int j=0; j<cwidth;j++)
      {
        int c = cell[i * cwidth + j];
        if(c == life) fill(0);
        else if(c==death) fill(255);
        
        rect(rw,rh,rw +20,rh+20);
        rw+=20;
      }
      
   }
   
}