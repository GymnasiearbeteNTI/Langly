
function translateCard() {
  event.target.children[0].style.display = 'none';
  event.target.children[1].style.display = 'block';
}

const turn = true;

function revealCards() {
  console.log(turn)
  if (turn == true){
    for (let i = 0; i < document.getElementsByClassName('hidden_card').length; i++) {
      document.getElementsByClassName('revealed_card')[i].style.display = 'block';
      document.getElementsByClassName('hidden_card')[i].style.display = 'none';
      var turn = false;
    }
  } else {
    for (let i = 0; i < document.getElementsByClassName('hidden_card').length; i++) {
      document.getElementsByClassName('revealed_card')[i].style.display = 'none';
      document.getElementsByClassName('hidden_card')[i].style.display = 'block';
      var turn = true;
    }
  }
}

const myQuestions = [
  {
    question: "Vilket av följande är ett verb?",
    answers: {
      a: 'Kakor',
      b: 'Snabb',
      c: 'Äta'
    },
    correctAnswer: 'c'
  },
  {
    question: "Fyll i det passande ordet: Jag köpte ___ äpple",
    answers: {
      a: 'en',
      b: 'ett'
    },
    correctAnswer: 'b'
  }
];

var quizContainer = document.getElementById('quiz');
var resultsContainer = document.getElementById('results');
var submitButton = document.getElementById('submit');

generateQuiz(myQuestions, quizContainer, resultsContainer, submitButton);

function generateQuiz(questions, quizContainer, resultsContainer, submitButton){

  function showQuestions(questions, quizContainer){
    // we'll need a place to store the output and the answer choices
    var output = [];
    var answers;

    // for each question...
    for(var i=0; i<questions.length; i++){
      
      // first reset the list of answers
      answers = [];

      // for each available answer...
      for(letter in questions[i].answers){

        // ...add an html radio button
        answers.push(
          '<label>'
            + '<input type="radio" name="question'+i+'" value="'+letter+'">'
            + letter + ': '
            + questions[i].answers[letter]
          + '</label>'
        );
      }

      // add this question and its answers to the output
      output.push(
        '<div class="question">' + questions[i].question + '</div>'
        + '<div class="answers">' + answers.join('') + '</div>'
      );
    }

    // finally combine our output list into one string of html and put it on the page
    quizContainer.innerHTML = output.join('');
  }


  function showResults(questions, quizContainer, resultsContainer){
    
    // gather answer containers from our quiz
    var answerContainers = quizContainer.querySelectorAll('.answers');
    
    // keep track of user's answers
    var userAnswer = '';
    var numCorrect = 0;
    
    // for each question...
    for(var i=0; i<questions.length; i++){

      // find selected answer
      userAnswer = (answerContainers[i].querySelector('input[name=question'+i+']:checked')||{}).value;
      
      // if answer is correct
      if(userAnswer===questions[i].correctAnswer){
        // add to the number of correct answers
        numCorrect++;
        
        // color the answers green
        answerContainers[i].style.color = 'DarkGreen';
      }
      // if answer is wrong or blank
      else{
        // color the answers red
        answerContainers[i].style.color = 'red';
      }
    }

    // show number of correct answers out of total
    resultsContainer.innerHTML = numCorrect + ' out of ' + questions.length;
  }

  // show questions right away
  showQuestions(questions, quizContainer);
  
  // on submit, show results
  submitButton.onclick = function(){
    showResults(questions, quizContainer, resultsContainer);
  }

}