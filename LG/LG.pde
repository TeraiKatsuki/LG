
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
   setCellAsRandom();
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

//draw.
void draw()
{
   background(255);
   drawcell();
}

//update cell.
void updatecell()
{
  
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
        if(c == life) fill(255);
        else if(c==death) fill(0);
        
        rect(rw,rh,rw +20,rh+20);
        rw+=20;
      }
      
   }
   
}