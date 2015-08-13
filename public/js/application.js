$(document).ready(function() {
	var gameNum = $(".data-div").attr("data-game-num");
	setUpBoardStart();
	var gameInfo = getPlayerInfo(gameNum)
	console.log(gameInfo);
	// console.log(gameInfo["player1"]);
	console.log(gameInfo["id1"]);
	console.log(gameInfo["id2"]);

	$(document).on("keyup", function(e) {
		switch (e.which) {
		case 81: {movePlayer(gameNum,1,gameInfo["id1"]);} break;
		case 80: {movePlayer(gameNum,2,gameInfo["id2"]);} break;
		case 67: {movePlayer(gameNum,3,gameInfo["id3"]);} break;
		case 78: {movePlayer(gameNum,4,gameInfo["id4"]);} break;
		case 16: {movePlayer(gameNum,5,gameInfo["id5"]);} break;
		case 17: {movePlayer(gameNum,6,gameInfo["id6"]);} break;
		case 18: {movePlayer(gameNum,7,gameInfo["id7"]);} break; 
		}
	});
});

function setUpBoardStart() {
	$(".cell1").toggleClass("active")
}

function movePlayer(gameNum, player, playerId) {
	updatePlayerPosition(gameNum, player, playerId, Math.ceil(Math.random() * 6));
}

function updatePlayerPosition(gameNum, playerNum, playerId, advanceByNum) {
	var boardLength = parseInt($(".racer_table").attr("num-cells"));
	var activeSpot = $(".strip" + playerNum + " td.active");
	activeSpot.toggleClass("active");
	var activeSpotClasses = activeSpot.attr("class");
	var activeSpotNum = parseInt(activeSpot.attr("cell"));
	var classesOfNewSpot = activeSpotClasses.replace(/cell\d*/,".cell" + (activeSpotNum + advanceByNum));

	// advance player
	if (activeSpotNum + advanceByNum <= boardLength) {
		var newSpot = $("." + classesOfNewSpot).toggleClass("active");
	} 
	// end of game
	else {
		$(".strip" + playerNum + " .cell" + boardLength).toggleClass("active");
		$(document).off();
		// sweetAlert("Player " + playerNum + " is the Winner!", "The player finished very quickly!","success");
		sendWinnerInfo(gameNum, playerId);
	}
}

function getPlayerInfo(gameNum) {
	var r = "boogabooga";
	var request = $.ajax({
		url: "/games/" + gameNum + "/play",
		method: "get",
    async: false
	})
	request.done(function(response) {
		r = $.parseJSON(response);
		return r;
	});
	return r;
}

function sendWinnerInfo(gameNum, winnerId) {
	var x = "boogabooga";
	var request = $.ajax({
		url: "/games/" + gameNum,
		method: "put",
		data: {winner_id: winnerId},
		async: false
	});
	// get JS to redirect the browser here. I want to redirect it to /games/gameNum

	// request.done(function(response) {
	// 	$.parseJSON(response);
	// 	console.log(response);
	// 	console.log(typeof response);
	// });
}