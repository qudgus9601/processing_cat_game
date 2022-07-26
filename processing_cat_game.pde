PFont font;
PImage img;
String[] arrows = {"left.png","up.png","right.png","down.png"};
String[] questions = new String[4];
int gameMode=0; // 0 Await, 1 Started, 2 Finish Game, 3 Win
int catFace=0; // 0 Normal, 1 ah ~
int meal=0;
int startTime=millis();
int remainTime=0;
int mealStartTime=0;
int finishTime =0;
int inputNum=0;
int[] questionsVal = new int[4];

void question() {
 for(int i=0;i<4;i++) {
   int a = round(random(0,3));
   questionsVal[i] = 37+a;
   questions[i] = arrows[a];
 }
}

void eatMeal() { 
  catFace = 1;
  mealStartTime = millis();
}

void keyPressed() {
  if(gameMode == 0) {
      gameMode = 1;
      remainTime = 600;
      meal = 10;
      startTime=millis();
      question();
  } else if(gameMode == 1) {
     if(questionsVal[inputNum] == keyCode) {
       questions[inputNum] = "none.png";
       if (inputNum == 3) {
         question();
         meal -= 1;
         if(meal == 0) {
           gameMode =3;
           finishTime = millis();
           inputNum=0;
         } else {
           inputNum = 0;
           eatMeal();
         }
       } else {
         inputNum += 1;
       }
     } else if(questionsVal[inputNum] != keyCode) {
       gameMode = 2;
       finishTime = millis();
       inputNum = 0;
     }
  }
}

void setup() {
  size(700, 800);
  font = createFont("ＭＳ ゴシック", 60);
  textFont(font);
}

void draw() {
 background(255);
 if(gameMode==0) {
   img = loadImage("mealPlease.png");
   image(img,260,-60);
   fill(0);
   textSize(16);
   text("Press Any Key",300,700);
   img = loadImage("thumbnail.png");
   image(img,80,250,400,300);
 } else if (gameMode == 1) {
   for(int i=0;i<4;i++) {
     img = loadImage(questions[i]);
     image(img,120+i*120,100,100,100);
   }
   textSize(32);
   fill(0);
   if(remainTime-((millis()-startTime)/100) == 0) {
      gameMode = 2; 
   }
   
   if(catFace == 0) {
     img = loadImage("thumbnail.png");
     image(img,160,320);
   } else if (catFace == 1) { 
     if(millis()-mealStartTime <= 1000) {
       if(((millis()/100)-(mealStartTime/100))%2 == 1) {
           img = loadImage("catAh.png");
           image(img,160,320);
       } else if (((millis()/100)-(mealStartTime/100))%2 == 0) {
         img = loadImage("thumbnail.png");
         image(img,160,320);
       }
     } else if (millis()-mealStartTime > 1000) {
       catFace = 0;
     }
   }
   
   if(meal >=10) {
     img = loadImage("meal100.png");
     image(img,150,500,200,200);
   } else if (meal >= 7 && meal < 10) {
     img = loadImage("meal70.png");
     image(img,150,500,200,200);
   } else if (meal >= 4 && meal < 7) {
     img = loadImage("meal40.png");
     image(img,150,500,200,200);
   } else if (meal >= 3 && meal < 4) {
     img = loadImage("meal30.png");
     image(img,150,500,200,200);
   } else if (meal == 2) {
     img = loadImage("meal20.png");
     image(img,150,500,200,200);
   } else if (meal == 1) {
     img = loadImage("meal10.png");
     image(img,150,500,200,200);
   } else if (meal == 0) {
     img = loadImage("meal  0.png");
     image(img,150,500,200,200);
   };
   text(remainTime-((millis()-startTime)/100),320,50);
 } else if (gameMode == 2) {
   img = loadImage("end.png");
   image(img,0,100);
   if (millis() - finishTime >= 5000) {
     gameMode = 0;
   }
 } else if (gameMode == 3) {
   img = loadImage("win.png");
   image(img,0,100);
   if (millis() - finishTime >= 5000) {
     gameMode = 0;
   }
 }
}
