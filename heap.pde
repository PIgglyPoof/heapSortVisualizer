import java.util.ArrayList;

String inputString = "";
HeapTree heap_tree = new HeapTree();

int i;
int parent;

void setup(){
  size(1500, 750);
  background(255);
  i=parent=-1;
}


void draw(){
  background(255);
  fill(255);
  strokeWeight(2);
  stroke(255,255,0);
  textAlign(LEFT);
  rect(1000,50,200,60);
  rect(1000,250,210,60);
  noStroke();
  textSize(60);
  fill(0);
  text("INSERT",1000,100);
  text("DELETE",1000,300);
  textSize(40);
  text(inputString,1000,200);
  
  heap_tree.drawTree(i,parent);
  
  if(heap_tree.isInserting){
    heap_tree.Insert();
    delay(1000);
  }
  else if(heap_tree.isDeleting){
    heap_tree.Delete();
    delay(1000);
  }
  
}

class Node{
  public int value;
  public float x;
  public float y;
  public float shift;
}

class HeapTree{
   ArrayList<Node> tree = new ArrayList<Node>();
   
   public int N=0;
   public boolean isInserting=false;
   public boolean isDeleting=false;
   
   float treeHeight = 100;
   float minimumDiameter = 10;
   
   public void Insert(){
     
         if(i>0&&tree.get(parent).value<tree.get(i).value){
           
           int temp = tree.get(parent).value;
           tree.get(parent).value=tree.get(i).value;
           tree.get(i).value=temp;
           
           i=parent;
           parent=(parent-1)/2;
           
           
         } else {
           
           this.isInserting = false;
           i=parent=-1;
           
         }
       
     }
     
     public void Delete(){
       
       int largest,left,right,maxPosition;
       left = 2*i + 1;
       right = 2*i + 2;
       largest = this.tree.get(i).value;
       maxPosition = i;
       
       if(left<this.N&&this.tree.get(left).value>largest){
         largest = this.tree.get(left).value;
         maxPosition = left;
       }
       if(right<this.N&&this.tree.get(right).value>largest){
         largest = this.tree.get(right).value;
         maxPosition = right;
       }
       
       if(maxPosition == i){
         i = -1;
         this.isDeleting = false;
       }
       else {
         int temp = this.tree.get(maxPosition).value;
         this.tree.get(maxPosition).value = this.tree.get(i).value;
         this.tree.get(i).value = temp;
         i = maxPosition;
       }
       
     }
   
   public void addNewNode(int value){
     Node newNode =  new Node();
     newNode.value = value;
     if(this.N==0){
       
       newNode.x = width/4;
       newNode.y = height/10;
       newNode.shift = newNode.x/2;
       this.tree.add(newNode);
       this.N=1;
       this.isInserting = false;
       
     } else {
       
       
       System.out.println(parent);
       if(this.N%2==0){
         newNode.x=tree.get(parent).x+tree.get(parent).shift;
       } else {
         newNode.x=tree.get(parent).x-tree.get(parent).shift;
       }
       
       
       newNode.y = tree.get(parent).y+treeHeight;
       
       newNode.shift=tree.get(parent).shift/2;
       
       this.tree.add(newNode);
       
       float x1 = this.tree.get(i).x;
       float y1 = this.tree.get(i).y;
       String value1 = this.tree.get(i).value+"";
       float strWidth1 = textWidth(value1);
       
       float x2 = this.tree.get(parent).x;
       float y2 = this.tree.get(parent).y;
       String value2 = this.tree.get(parent).value+"";
       float strWidth2 = textWidth(value2);
       
       strokeWeight(6);
       stroke(0,255,255);
       line(x1,y1,x2,y2);
       
       fill(255);
       strokeWeight(2);
       stroke(0);
       ellipse(x1,y1,strWidth1+minimumDiameter,strWidth1+minimumDiameter);
       ellipse(x2,y2,strWidth2+minimumDiameter,strWidth2+minimumDiameter);
       
       fill(0);
       text(value1,x1,y1);
       text(value2,x2,y2);
       
       this.N++;
       
       
     }
     
     
   }
   
   public void mousePressed(){
  
    if(checkInsert(mouseX,mouseY)&&inputString!=""){
      System.out.println(Integer.parseInt(inputString));
      
      heap_tree.isInserting = true;
      
      i=heap_tree.N;
      parent=(i-1)/2;
      
      addNewNode(Integer.parseInt(inputString));
      
      inputString="";
      noStroke();
      fill(255);
      rect(1000,150,200,100);
    } else if(checkDelete(mouseX,mouseY)&&!this.tree.isEmpty()){
        if(this.N==1){
          this.tree.remove(0);
        }
        else {
          
          this.isDeleting = true;
          
          if(this.N==1){
            this.isDeleting = false;
            this.tree.clear();
            return;
          }
          
          float x1 = this.tree.get(0).x;
          float y1 = this.tree.get(0).y;  
          String value1 = this.tree.get(0).value+"";
          float strWidth1 = textWidth(value1);
          
          float x2 = this.tree.get(this.tree.size()-1).x;
          float y2 = this.tree.get(this.tree.size()-1).y;
          String value2 = this.tree.get(this.tree.size()-1).value+"";
          float strWidth2 = textWidth(value2);
          
          fill(255,0,0);
          stroke(0);
          strokeWeight(2);
          ellipse(x1,y1,strWidth1+minimumDiameter,strWidth1+minimumDiameter);
          fill(0,255,255);
          ellipse(x2,y2,strWidth2+minimumDiameter,strWidth2+minimumDiameter);
          
          textAlign(CENTER,CENTER);
          fill(0);
          textSize(20);
          text(value1,x1,y1);
          text(value2,x2,y2);
          
          this.tree.get(0).value = Integer.parseInt(value2);
          this.tree.get(this.tree.size()-1).value = Integer.parseInt(value1);
          
          i = 0;
          this.tree.remove(this.tree.size()-1);
          this.N--;
          
        }
    }
    
  }
   
  boolean checkInsert(int x,int y){
    if(x>=1000&&x<=1200&&y>=50&&y<=110){
      return true; 
    }
    else{
      return false;
    }
  }
  
  boolean checkDelete(int x,int y){
    if(x>=1000&&x<=1210&&y>=250&&y<=310){
      return true; 
    }
    else{
      return false;
    }
  }
   

void keyPressed() {
  if(key>='0'&&key<='9'){
    inputString+=key;
  } if(key==BACKSPACE&&inputString.length()>0){
    inputString = inputString.substring(0,inputString.length()-1);
  }
}
  
  
  void drawTree(int a , int b){
    strokeWeight(6);
    stroke(255,255,0);
    textAlign(CENTER,CENTER);
    
    // DRAWING EDGES OF GRAPH
    for(int i = 0;i < this.N ; ++i){
      
      int left = 2*i+1;
      int right = 2*i+2;
      
      if(left<this.N){
        line(this.tree.get(i).x,this.tree.get(i).y,this.tree.get(left).x,this.tree.get(left).y);
      }
      
      if(right<this.N){
        line(this.tree.get(i).x,this.tree.get(i).y,this.tree.get(right).x,this.tree.get(right).y);
      }
      else{
        break;
      }
      
    }
    
    fill(0);
    textSize(20);
    
    if(this.isInserting&&a!=-1){
      stroke(0,255,255);
      line(this.tree.get(a).x,this.tree.get(a).y,this.tree.get(b).x,this.tree.get(b).y);
    } 
    else if(this.isDeleting&&a!=-1){
      stroke(255,0,0);
      int left = 2*a+1;
      int right = 2*a +2;
      if(left<this.N)
        line(this.tree.get(a).x,this.tree.get(a).y,this.tree.get(left).x,this.tree.get(left).y);
      if(right<this.N)
        line(this.tree.get(a).x,this.tree.get(a).y,this.tree.get(right).x,this.tree.get(right).y);
    }
    
    for(int i = 0;i < this.N ; ++i){
        float x = this.tree.get(i).x;
        float y = this.tree.get(i).y;
        String value = this.tree.get(i).value+"";
        float strWidth = textWidth(value);
        
        fill(255);
        strokeWeight(2);
        stroke(0);
        
        ellipse(x,y,strWidth+minimumDiameter,strWidth+minimumDiameter);
        
        fill(0);
        text(value,x,y);
           
    }
    
  }
  
}

void keyPressed(){
  
  heap_tree.keyPressed();
  
}


void mousePressed(){
  
  heap_tree.mousePressed();
  
}
