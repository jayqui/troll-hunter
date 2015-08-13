$(document).ready(function(){ 
  dynamicInputs();
});

function dynamicInputs() {
  $("#players-form").on("change","input", function(){
      var allFilled=true;
      var lastInputField=0;
      $("input").each(function() {
          if ($(this).val() =="") {
              allFilled=false;
              return false;
          }
          lastInputField++;
      });

      if (allFilled) {
          var newInput = $("<input type='text' id='player-" + lastInputField +"'" +
            "name='players[" + lastInputField + "]' placeholder='Player " + lastInputField + "'></span>");
          newInput.appendTo("#inputs-div");
          newInput.focus();
      }
  });
};