
allTypeOfLeaves = new Array(2)
Leaf1 =new Image();
Leaf1 = allTypeOfLeaves[0] = "/holiday/leaf.png";//path to the image you will use
Leaf2 =new Image();
Leaf2 = allTypeOfLeaves[1] ="/holiday/leaf1.png";//you can have up to 3 different kind of leaves
Leaf3 =new Image();
Leaf3 = allTypeOfLeaves[2] ="/holiday/leaf2.png";//possible to add more

var speedC = .5;//here you can define speed of leaves
var rotation = 0;//define rotation of leaves
var rotationTrue = 0//whether leaves rotate (1) or not (0)
var numberOfLeaves = 9;//define number of leaves
var size = 40;//general size of leaves, final size is calculated randomly (with this number as general parameter)
var typeOfLeaf = 0;//type of leav, 0 - maple leaf, 1 - saw leaf, 2 - normal leaf, 3 all types together
var fps = 75;

Ypos=new Array();
Xpos=new Array();
Speed = new Array();
startYPos = new Array();
CStrafe=new Array();
Strafe=new Array();
rotationAll = new Array();
height = new Array();
width = new Array();
var counter = 0;
opacityLeaf = new Array();

WinWidth = $(window).width();//width and height of browser window
WinHeight = $(window).height();

for (i = 0 ;i < numberOfLeaves;i++){
  var randomLeaf = Math.floor(Math.random()*allTypeOfLeaves.length);//which leaf is going to be used

  if (typeOfLeaf == 0)
    rndLeaf=allTypeOfLeaves[0];
  if (typeOfLeaf == 1)
    rndLeaf=allTypeOfLeaves[1];
  if (typeOfLeaf == 2)
    rndLeaf=allTypeOfLeaves[2];
  if (typeOfLeaf == 3)
    rndLeaf=allTypeOfLeaves[randomLeaf];

  console.log(randomLeaf, rndLeaf);

   
   width[i]=Math.round(Math.random()*size+20);//random width and height according to chosen parameter
     height[i]=Math.round(Math.random()*size+20);
   if (width[i] > height[i]*1.5 || height[i] > width[i]*1.5) 
    width[i] = height[i];
  
   Ypos[i] = -Math.random() * 500 - 40;//starting y position of leaves

   Xpos[i] = Math.round(Math.random()*(WinWidth)-width[i]*3);//randomization of x position of leaves
   opacityLeaf[i] = 0.3;
   Speed[i]= Math.random()*speedC + 2;//speed of leaves
   rotationAll[i] = Math.round(Math.random()) * rotation + Speed[i];//rotation of leaves
   CStrafe[i]=0;
   Strafe[i]=Math.random()*0.06 + 0.05;//strength of right/left strafe


  var img = document.createElement("img");
      img.className ="leaves"+i;
      img.src = rndLeaf;
      img.style.backgroundColor = "none";
      img.style.position = "absolute";
      img.style.top = Ypos[i];
      img.style.left = Xpos[i];
      img.style.height = height[i];
      img.style.width = width[i];
      img.style.opacity = opacityLeaf[i];

  var bdy = document.getElementsByTagName("body")[0];
      bdy.appendChild(img);

}   
function fallingLeaves(){ 

  for (i = 0 ;i < numberOfLeaves;i++)
    {
    strafey = Speed[i]*Math.sin(90*Math.PI/180);//defining strafe
    strafex = Speed[i]*Math.cos(CStrafe[i]);
    rotationAll[i]+=rotation+Speed[i];

    Ypos[i]+=strafey;
    Xpos[i]+=strafex; 
    if (Ypos[i] < 0){//setting opacity
       if(!$.browser.msie){
        opacityLeaf[i]=1;
        $(".leaves"+i).css({opacity:opacityLeaf[i]});     
      }
    }
    if (Ypos[i] > WinHeight - height[i] * 4){//leaves slowly disappearing at the end of browser window
      if(!$.browser.msie){
        opacityLeaf[i]-=0.05; 
        $(".leaves"+i).css({opacity:opacityLeaf[i]});
      }
    }
    if (Ypos[i] > WinHeight - (width[i] + height[i]/2)){//when leaves reach certain browser height they are transported back to the begining
      
      Ypos[i]=-50;
      Xpos[i]=Math.round(Math.random()*WinWidth-width[i]*4);
      Speed[i]= Math.random()*speedC + 2;
    }

    if (rotationTrue == 1){//decision whether rotation is applied or not
      $(".leaves"+i).css({top: Ypos[i], left: Xpos[i]});
      $(".leaves"+i).rotate3Di(rotationAll[i], 0);
    }
    else if (rotationTrue == 0){
      $(".leaves"+i).css({top: Ypos[i], left: Xpos[i]});
    }
    CStrafe[i]+=Strafe[i];
    }
  
  setTimeout('fallingLeaves()',50);//function time out - fps of leaves

}
//window.onload=fallingLeaves