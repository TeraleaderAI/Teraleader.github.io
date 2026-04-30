function choice(va, qFile){

	

	if(va == 1){
		document.getElementById("gnbSub1").style.display ="";
		document.getElementById("gnbSub2").style.display ="none";
		document.getElementById("gnbSub3").style.display ="none";
		document.getElementById("gnbSub4").style.display ="none";


		q1.src = "/images/common/gnb_topmenu01_on.gif";
		q2.src = "/images/common/gnb_topmenu02_off.gif";
		q3.src = "/images/common/gnb_topmenu03_off.gif";
		q4.src = "/images/common/gnb_topmenu04_off.gif";

	
		
	}
	
	
	else if(va == 2){
		document.getElementById("gnbSub1").style.display ="none";
		document.getElementById("gnbSub2").style.display ="";
		document.getElementById("gnbSub3").style.display ="none";
		document.getElementById("gnbSub4").style.display ="none";



		q1.src = "/images/common/gnb_topmenu01_off.gif";
		q2.src = "/images/common/gnb_topmenu02_on.gif";
		q3.src = "/images/common/gnb_topmenu03_off.gif";
		q4.src = "/images/common/gnb_topmenu04_off.gif";




	}
	
	
	else if(va == 3){
		document.getElementById("gnbSub1").style.display ="none";
		document.getElementById("gnbSub2").style.display ="none";
		document.getElementById("gnbSub3").style.display ="";
		document.getElementById("gnbSub4").style.display ="none";



		q1.src = "/images/common/gnb_topmenu01_off.gif";
		q2.src = "/images/common/gnb_topmenu02_off.gif";
		q3.src = "/images/common/gnb_topmenu03_on.gif";
		q4.src = "/images/common/gnb_topmenu04_off.gif";




	}
	else if(va == 4){
		document.getElementById("gnbSub1").style.display ="none";
		document.getElementById("gnbSub2").style.display ="none";
		document.getElementById("gnbSub3").style.display ="none";
		document.getElementById("gnbSub4").style.display ="";




		q1.src = "/images/common/gnb_topmenu01_off.gif";
		q2.src = "/images/common/gnb_topmenu02_off.gif";
		q3.src = "/images/common/gnb_topmenu03_off.gif";
		q4.src = "/images/common/gnb_topmenu04_on.gif";



	}
	
	else if(va == 5){
		document.getElementById("gnbSub1").style.display ="none";
		document.getElementById("gnbSub2").style.display ="none";
		document.getElementById("gnbSub3").style.display ="none";
		document.getElementById("gnbSub4").style.display ="none";
		document.getElementById("gnbSub5").style.display ="";



		q1.src = "images/common/gnb_topmenu01_off.gif";
		q2.src = "images/common/gnb_topmenu02_off.gif";
		q3.src = "images/common/gnb_topmenu03_off.gif";		
		q4.src = "images/common/gnb_topmenu04_off.gif";
		q5.src = "images/common/gnb_topmenu05_on.gif";


	}
	
	
}
