document.addEventListener('DOMContentLoaded', function() {
  var modal = document.getElementById('loginDialog');
  var closeButton = document.querySelector('.close');
  var loginForm = document.getElementById('loginForm');

  // Open the modal
  function openModal() {
    modal.style.display = 'block';
  }

  // Close the modal
  function closeModal() {
    modal.style.display = 'none';
  }

  // Close modal when clicking on close button
  closeButton.onclick = closeModal;

  // Close modal when clicking outside the modal
  window.onclick = function(event) {
    if (event.target == modal) {
      closeModal();
    }
  };

  // Submit login form
  loginForm.addEventListener('submit', function(event) {
    event.preventDefault();
    var username = document.getElementById('username').value;
    var password = document.getElementById('password').value;

    // Here you can add code to handle login (e.g., sending data to a server for authentication)
    // For this example, let's just log the username and password
    console.log('Username:', username);
    console.log('Password:', password);

    // Close the modal after handling login
    closeModal();
  });
});
