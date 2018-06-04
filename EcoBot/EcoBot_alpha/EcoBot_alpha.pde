import ddf.minim.*;  //import the Minim library

//create Minim variable
Minim minim;

//create AudioPlayer variable
AudioPlayer explosionSound;
AudioPlayer gameover;
AudioPlayer angry;
AudioPlayer win;
AudioPlayer trashSound;
AudioPlayer gameSound;

// Trash related varriables
int trashTotal = 1000;
PImage[] trash = new PImage[trashTotal];
float[] trashX = new float[trashTotal];// x position of shape
float[] trashY = new float[trashTotal];
float[] trashSpeed = new float[trashTotal];
int trashWidth = 30, trashHeight = 30;

//bombs
int bombTotal = 300;
PImage[] bomb = new PImage[bombTotal];
float[] bombX = new float[bombTotal];
float[] bombY = new float[bombTotal];
float[] bombSpeed = new float[bombTotal];
int bombWidth = 40, bombHeight = 40;

//explosion
PImage explosion;

//EcoBot related variables
PImage showedBot;
PImage ecoBot;
PImage ecoBotAngry;
float ecoBotX, ecoBotY;
int botWidth = 120, botHeight = 120;
int ecoBotSpeed = 15;

//Trash cans
int trashCanTotal = 4;
PImage trashCan[] = new PImage[trashCanTotal];
int trashCanX[] = new int[trashCanTotal];
int trashCanY[] = new int[trashCanTotal];
int trashCanWidth[] = new int[trashCanTotal];
int trashCanHeight[] = new int[trashCanTotal];
int trashCanSpeed = 40;
int maxYtrashCan = 550;



//Game Flow related variables
int levels = 4;
PImage bg[] = new PImage[levels];//background
int score;
int plasticBag = 10, paperBag = 10, glassBag = 10, metalBag = 10;
int lives; 
int maxScore = 10;
//time
int counter;
int time;

//Stage

int stageNum = 0;

// Welcome Page
PImage welcomeBg;

//Congratulations 
PImage congrats;

//Game Over
PImage over;

//Bonus
int acceleratorTotal = 200;
PImage accelerator[] = new PImage[acceleratorTotal];
float acceleratorX[] = new float[acceleratorTotal];
float acceleratorY[] = new float[acceleratorTotal];
int acceleratorWidth;
int acceleratorHeight;
float acceleratorSpeed;

//Extra
int extraTotal = 100;
PImage extra[] = new PImage[acceleratorTotal];
float extraX[] = new float[acceleratorTotal];
float extraY[] = new float[acceleratorTotal];
int extraWidth;
int extraHeight;
float extraSpeed;

void setup() {
      //create a Minim object 
  minim = new Minim(this); 

  //load the song into the player
  explosionSound = minim.loadFile("explosion.wav");
  angry = minim.loadFile("angry.wav");
  //win = minim.loadFile("win.wav");
  gameover = minim.loadFile("gameover.wav");
  trashSound =  minim.loadFile("trash.wav");
  //gameSound = minim.loadFile("game.wav");
  
  //gameSound.loop();
  
  //initial values
  lives = 7;
  trashTotal = 1000;
  plasticBag = 10;
  paperBag = 10;
  glassBag = 10; 
  metalBag = 10;
  score = 0;

  counter = 0;
  time = 0;

  size(700, 700);

  //Welcome Background
  welcomeBg = loadImage("WelcomePage.png");

  // initialzation of trash
  for (int i = 0; i < 1000; i++) {
    trashX[i] = int(random(5, 400));    
    trashY[i] = int(random(-100000, -500));
    trashSpeed[i] = 1;//int(random(1, 3));
    //plastic
    if (i < 250) {
      trash[i] = loadImage("recycle_items" + int(random(1, 3)) + ".png");
    }
    // paper
    else if (i < 500) {
      trash[i] = loadImage("recycle_items" + int(random(4, 6)) + ".png");
    }
    //glass
    else if (i < 750) {
      trash[i] = loadImage("recycle_items" + int(random(7, 9)) + ".png");
    }
    //metal
    else if (i < 1000) {
      trash[i] = loadImage("recycle_items" + 10 + ".png");
    }
  }


  // initial position of the EcoBot
  ecoBotY = 550;
  ecoBotX = 250;

  //loading the image of Eco-Bot
  ecoBot = loadImage("robot.png");
  ecoBotAngry = loadImage("ecoBotAngry.png");
  showedBot = ecoBot;

  //Bomb initialization
  for (int i = 0; i < bombTotal; i++) {
    bomb[i] = loadImage("bomb.png");
    bombX[i] = int(random(5, 450-bombWidth));    
    bombY[i] = int(random(-200000, -500));
    bombSpeed[i] = 1;
  }

  //exlposion initialization
  explosion = loadImage("explosion.png");

  //Trash Can initialization
  for (int i = 0; i<trashCanTotal; i++) {
    trashCan[i] = loadImage("tube"+i+".png");
    trashCanX[i] = 360;
    trashCanY[i] = 700;
    trashCanWidth[i] = 70;
    trashCanHeight[i] = 120;
  }
  // accelerator initialization
  for (int i = 0; i < acceleratorTotal; i++) {
    accelerator[i] = loadImage("battery1.png");
    acceleratorX[i] = int(random(0, 400));
    acceleratorY[i] = int(random(-500000, -500));
    acceleratorWidth = 30;
    acceleratorHeight = 45;
  }

  // Extra initialization
  for (int i = 0; i < extraTotal; i++) {
    extra[i] = loadImage("extra.png");
    extraX[i] = int(random(0, 400));
    extraY[i] = int(random(-200000, -500));
    extraWidth = 50;
    extraHeight = 50;
  }


  //loading background
  for (int k = 0; k < 4; k++) {
    bg[k] = loadImage("bg"+(k+1)+".png");
  }

  //Loading Congrats
  congrats = loadImage("Congrats.png");

  //GameOver
  over = loadImage("over.png");
}

void draw() {
  if (stageNum == 0) {
    drawWelcome();
  } else if (stageNum == 1 ) {
    drawStage1();
  } else if (stageNum == 2) {
    drawStage2();
  } else if (stageNum == 3) {
    drawStage3();
  } else if (stageNum == 4) {
    drawStage4();
  }
  counter +=1;
  timeSec();
}


void keyPressed() {

  // Go back
  if (key == 'g') {
    stageNum=0;
  }
  // Welcome Page
  else if (stageNum==0) {
    stageNum =1;
  }

  //Next Level
  if (stageNum==1 && score == maxScore && key == 'd') {
    stageNum = 2;
    setup();
  }


  if (stageNum==2 && score == maxScore && key == 'd') {
    stageNum = 3;
    setup();
  }
  if (stageNum==3 && score == maxScore && key == 'd') {
    stageNum = 4;
    setup();
  }
  if (stageNum==4 && score == maxScore && key == 'd') {
    stageNum = 0;
  }

  // Game Over
  if (lives < 1&&stageNum==1 && key=='a') {
    stageNum = 1;
    setup();
  }
  if (lives < 1&&stageNum==2 && key=='a') {
    stageNum = 2;
    setup();
  }
  if (lives < 1&&stageNum==3 && key=='a') {
    stageNum = 3;
    setup();
  }
  if (lives < 1&&stageNum==4 && key=='a') {
    stageNum = 4;
    setup();
  }
  //trashcan Caller

  if (key == 'q') {  
    trashCanY[0] = trashCanY[0] - trashCanSpeed;
    if (trashCanY[0] < maxYtrashCan) {
      trashCanY[0] = maxYtrashCan;
    }
  }
  if (key == 'w') {
    trashCanY[1] = trashCanY[1] - trashCanSpeed;
    if (trashCanY[1] < maxYtrashCan) {
      trashCanY[1] = maxYtrashCan;
    }
  }
  if (key == 'e') {
    trashCanY[2] = trashCanY[2] - trashCanSpeed;
    if (trashCanY[2] < maxYtrashCan) {
      trashCanY[2] = maxYtrashCan;
    }
  }
  if (key == 'r') {
    trashCanY[3] = trashCanY[3] - trashCanSpeed;
    if (trashCanY[3] < maxYtrashCan) {
      trashCanY[3] = maxYtrashCan;
    }
  }
  //move EcoBot
  if (key == CODED) {
    if (keyCode == LEFT) {
      ecoBotX = ecoBotX - ecoBotSpeed;
    }  
    if (keyCode == RIGHT) {
      ecoBotX = ecoBotX + ecoBotSpeed;
      if (ecoBotX>450-botWidth) {
        ecoBotX = 470 - botWidth;
      }
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void sort_the_trash(int a) {
  if (a < 250) {
    plasticBag -=1;
  } else if (a < 500) {
    paperBag -=1;
  } else if (a < 750) {
    glassBag -=1;
  } else if (a < 1000) {
    metalBag -=1;
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void noCatch() {
  for (int i = 0; i < trashTotal; i++) {
    if (trashY[i] > 700) {
      if(!(score == maxScore||lives < 1)){
      lives = lives - 1;
      trashY[i] = - 1000000;
      }
    }
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void nextLevel(int points) {
  if (points == maxScore) {
    win.play();
    image(congrats, 25, 100, 400, 400);
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void gameOver(int livesleft) {
  if (livesleft <1 ) {
    gameover.play();
    gameover.rewind();
    image(over, 25, 100, 400, 400);
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void speed_accelerator(float speed) {
  //speed accelerator
  if (counter % 60 == 0) {
    speed = speed + 0.001;
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void display_score() {
  textSize(20);
  fill(0);
  text("Score: " + score, 470, 70);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void display_space_in_bags() {
  textSize(25);
  fill(0);
  text("Plastic: " + plasticBag, 500, 125);

  textSize(25);
  fill(0);
  text("Paper: " + paperBag, 500, 150);

  textSize(25);
  fill(0);
  text("Glass: " + glassBag, 500, 175);

  textSize(25);
  fill(0);
  text("Metal: " + metalBag, 500, 200);
}
//////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
void display_lives() {
  textSize(20);
  fill(0);
  text("Lives: " + lives, 600, 70);
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
void displayBot() {
  image(showedBot, ecoBotX, ecoBotY, botWidth, botHeight);
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void displayTrash() {
  for (int i = 0; i < trashTotal; i=i+1) {
    image(trash[i], trashX[i], trashY[i]);
    trashY[i] = trashY[i] + trashSpeed[i];
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
void displayBomb() {
  for (int i = 0; i < bombTotal; i=i+1) {
    image(bomb[i], bombX[i], bombY[i], bombWidth, bombHeight);
    bombY[i] = bombY[i] + bombSpeed[i];
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void displayAccelerator() {
  for (int i = 0; i < acceleratorTotal; i=i+1) {
    image(accelerator[i], acceleratorX[i], acceleratorY[i], acceleratorWidth, acceleratorHeight);
    acceleratorY[i] = acceleratorY[i] + acceleratorSpeed;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void displayExtra() {
  for (int i = 0; i < extraTotal; i=i+1) {
    image(extra[i], extraX[i], extraY[i], extraWidth, extraHeight);
    extraY[i] = extraY[i] + extraSpeed;
  }
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void trashCollisionDetector() {
  for (int i = 0; i <trashTotal; i=i+1) {
    if (ecoBotX + botWidth >= trashX[i] && ecoBotX <= trashX[i] + trashWidth && ecoBotY +botHeight >=trashY[i] 
      && ecoBotY <= trashY[i] + trashHeight && lives >0 && score < maxScore) {
      //remove trash
      if (!((i<=250 && plasticBag == 0)|| (i>250&&i<=500 && paperBag == 0) 
        || (i>500 && i<=750 && glassBag == 0) || (i> 750 &&i<=1000 && metalBag == 0))) {
        // remove trash
        trashY[i] = -100000;
        // score counter
        score +=1;
        //trash sorter
        sort_the_trash(i);
        trashSound.play();
        trashSound.rewind();
      }
    }
    speed_accelerator(trashSpeed[i]);
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void trashCanDisplayAndCollisionDetector() {
  for (int i = 0; i<trashCanTotal; i++) {
    image(trashCan[i], trashCanX[i], trashCanY[i], trashCanWidth[i], trashCanHeight[i]);
    if (ecoBotX + (botWidth-10) >= trashCanX[0] && ecoBotX <= trashCanX[0] + trashCanWidth[0]&& trashCanY[0]==maxYtrashCan && lives > 0 && score < maxScore) {
      plasticBag = 10;
    }
    if (ecoBotX + (botWidth-10) >= trashCanX[1] && ecoBotX <= trashCanX[1] + trashCanWidth[1] && trashCanY[1] == maxYtrashCan && lives > 0 && score < maxScore) {
      metalBag = 10;
    }
    if (ecoBotX + (botWidth-10) >= trashCanX[2] && ecoBotX <= trashCanX[2] + trashCanWidth[2] && trashCanY[2] == maxYtrashCan && lives > 0 && score < maxScore) {
      paperBag = 10;
    }
    if (ecoBotX + (botWidth-10) >= trashCanX[3] && ecoBotX <= trashCanX[3] + trashCanWidth[3] && trashCanY[3] == maxYtrashCan && lives > 0 && score < maxScore) {
      glassBag = 10;
    }
    trashCanY[i] = trashCanY[i] + 1;
    if (trashCanY[i] > 700) {
      trashCanY[i] = 700;
    }
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void acceleratorCollisionDetector() {
  for (int j = 0; j < acceleratorTotal; j++) {
    if (ecoBotX + (botWidth-25) >= acceleratorX[j] && ecoBotX <= acceleratorX[j] + (acceleratorWidth-10) && ecoBotY +(botHeight+15) >=acceleratorY[j] 
      && (ecoBotY+15) <= acceleratorY[j] + (acceleratorHeight) && lives > 0 && score < maxScore) {
      time = 0;
      ecoBotSpeed = 25;
      showedBot = ecoBotAngry;  
      acceleratorY[j] = -100000;
      angry.play();
      angry.rewind();
    }
    if (time > 4) {
      ecoBotSpeed = 15;
      showedBot = ecoBot;
    }
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void bombCollisionDetector() {
  for (int j = 0; j < bombTotal; j++) {
    if (ecoBotX + (botWidth-25) >= bombX[j] && ecoBotX <= bombX[j] + (bombWidth-10) && ecoBotY +(botHeight+15) >=bombY[j] 
      && (ecoBotY+15) <= bombY[j] + (bombHeight) && showedBot == ecoBot && lives > 0 && score < maxScore) {
      lives = lives - 1;
      {
        image(explosion, bombX[j], bombY[j], 40, 40);
      }
      bombY[j] = -1000000;
      explosionSound.play();
      explosionSound.rewind();
    }
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void extraCollisionDetector() {
  for (int j = 0; j < extraTotal; j++) {
    if (ecoBotX + (botWidth-25) >= extraX[j] && ecoBotX <= extraX[j] + (extraWidth-10) && ecoBotY +(botHeight+15) >=extraY[j] 
      && (ecoBotY+15) <= extraY[j] + (extraHeight) && lives > 0 && score < maxScore) {
      extraY[j] = -100000;
      angry.play();
      angry.rewind();
      for (int i = 0; i < trashTotal; i++) {
        if (trashY[i]> 0) { 
          trashY[i] = -100000;
        }
      } 
      for (int i = 0; i < bombTotal; i++) {
        if (bombY[i]> 0) { 
          bombY[i] = -100000;
        }
      } 
      for (int i = 0; i < acceleratorTotal; i++) {
        if (acceleratorY[i]> 0) { 
          acceleratorY[i] = -100000;
        }
      }
    }
  }
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void instructions() {
  fill(255);
  textSize(13);
  text("Press Q to empty PLASTIC BAG", 470, 350);
  text("Press W to empty METAL BAG", 470, 375);
  text("Press E to empty PAPER BAG", 470, 400);
  text("Press R to empty GLASS BAG", 470, 425);
  text("Use ARROWS to move", 470, 465);
  text("Press G to exit", 470, 500);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void drawWelcome() {
  image(welcomeBg, 0, 0, 700, 700);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void drawStage1() {
  // values
  for (int i = 0; i < bombTotal; i=i+1) {
    bombSpeed[i] = 1;
  }
  for (int i = 0; i < trashTotal; i=i+1) {
    trashSpeed[i] = 1;
  }
  acceleratorSpeed = 1;
  extraSpeed = 1;
  //background(255);
  image(bg[0], 0, 0, 450, 700);

  // interface
  fill(#7E7777); // area of instructions
  rect(450, 0, 350, 700);

  // ground
  //fill(#E8EAE8);
  //rect(0, 650, 450, 50 );

  //score
  display_score();

  //bags
  display_space_in_bags();

  //lives
  display_lives();

  //INSTRUCTIONS
  instructions();

  //display trash
  displayTrash();

  //display bomb
  displayBomb();

  //display accelerator
  displayAccelerator();

  //display Extra
  displayExtra();

  //accelerator collision detector
  acceleratorCollisionDetector();
  
  //Extra collision Detector
  extraCollisionDetector();

  //No catch detector
  noCatch();


  //Collision detector
  trashCollisionDetector();

  //Bomb collision detector
  bombCollisionDetector();

  // display the EcoBot
  displayBot();

  //display the TrashCan
  //And trashCan collision detector
  trashCanDisplayAndCollisionDetector();



  gameOver(lives);
  nextLevel(score);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void drawStage2() {
  //values 
  for (int i = 0; i < bombTotal; i=i+1) {
    bombSpeed[i] = 2;
  }
  for (int i = 0; i < trashTotal; i=i+1) {
    trashSpeed[i] = 2;
  }
  acceleratorSpeed = 2;
  extraSpeed = 2;
  //background(255);
  image(bg[1], 0, 0, 450, 700);

  // interface
  fill(#7E7777); // area of instructions
  rect(450, 0, 350, 700);

  // ground
  //fill(#E8EAE8);
  //rect(0, 650, 450, 50 );

  //score
  display_score();

  //bags
  display_space_in_bags();

  //lives
  display_lives();

  //INSTRUCTIONS
  instructions();

  //display trash
  displayTrash();

  //display bomb
  displayBomb();

  //display accelerator
  displayAccelerator();

  //display Extra
  displayExtra();

  //accelerator Collision Detector
  acceleratorCollisionDetector();
  
  //Extra collision detector
  extraCollisionDetector();

  //No catch detector
  noCatch();

  //Collision detector
  trashCollisionDetector();
  //Bomb collision detector
  bombCollisionDetector();

  // display the EcoBot
  displayBot();

  //display the TrashCan
  //And trashCan collision detector
  trashCanDisplayAndCollisionDetector();



  gameOver(lives);
  nextLevel(score);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void drawStage3() {
  //values
  for (int i = 0; i < bombTotal; i=i+1) {
    bombSpeed[i] = 2.8;
  }
  for (int i = 0; i < trashTotal; i=i+1) {
    trashSpeed[i] = 2.8;
  }
  acceleratorSpeed = 2.8;
  extraSpeed = 2.8;

  //background(255);
  image(bg[2], 0, 0, 450, 700);

  // interface
  fill(#7E7777); // area of instructions
  rect(450, 0, 350, 700);

  // ground
  //fill(#E8EAE8);
  //rect(0, 650, 450, 50 );

  //score
  display_score();

  //bags
  display_space_in_bags();

  //lives
  display_lives();

  //INSTRUCTIONS
  instructions();

  //display trash
  displayTrash();

  //display bomb
  displayBomb();

  //display accelerator
  displayAccelerator();

  //display Extra
  displayExtra();

  //accelerator Collision Detector
  acceleratorCollisionDetector();
  
  //Extra collision Detector
  extraCollisionDetector();

  //No catch detector
  noCatch();

  //Collision detector
  trashCollisionDetector();

  //Bomb collision detector
  bombCollisionDetector();

  // display the EcoBot
  displayBot();

  //display the TrashCan
  //And trashCan collision detector
  trashCanDisplayAndCollisionDetector();


  gameOver(lives);
  nextLevel(score);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void drawStage4() {
  for (int i = 0; i < bombTotal; i=i+1) {
    bombSpeed[i] = 3.2;
  }
  for (int i = 0; i < trashTotal; i=i+1) {
    trashSpeed[i] = 3.2;
  }
  acceleratorSpeed = 3.2;
  extraSpeed = 3.2;
  //background(255);
  image(bg[3], 0, 0, 450, 700);


  // interface
  fill(#7E7777); // area of instructions
  rect(450, 0, 350, 700);

  // ground
  //fill(#E8EAE8);
  //rect(0, 650, 450, 50 );

  //score
  display_score();

  //bags
  display_space_in_bags();

  //lives
  display_lives();

  //INSTRUCTIONS
  instructions();

  //display trash
  displayTrash();

  //display bomb
  displayBomb();

  //display accelerator
  displayAccelerator();

  //display Extra
  displayExtra();

  //accelerator Collision Detector
  acceleratorCollisionDetector();
  
  //Extra collision Detector
  extraCollisionDetector();

  // No catch detector
  noCatch();
  //Collision detector
  trashCollisionDetector();
  //Bomb collision detector
  bombCollisionDetector();

  // display the EcoBot
  displayBot();

  //display the TrashCan
  //And trashCan collision detector
  trashCanDisplayAndCollisionDetector();

  gameOver(lives);
  nextLevel(score);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////'
void timeSec() {
  if (counter%60==0) {
    time +=1;
  }
}

