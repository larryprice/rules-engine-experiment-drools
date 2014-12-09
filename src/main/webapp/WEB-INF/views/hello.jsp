<%@ page language="java" contentType="text/html;charset=ISO-8859-1"%>
<html>
<head>
  <title>Simple Drools Demo</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
  <link href='http://fonts.googleapis.com/css?family=Average+Sans' rel='stylesheet' type='text/css'>
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <style>
    html,body,input {font-family: 'Average Sans', sans-serif;}
  </style>
</head>
<body>
  <div class="container">
    <div class="row">
      <div class="col-md-offset-3 col-md-6 col-xs-12">
        <h2 class="text-center">
          <strong>
            Update the information below
          </strong>
        </h2>
      </div>
    </div>
    <div class="row">
      <div class="col-md-offset-3 col-md-6">
        <form class="form-horizontal">
          <div class="form-group">
            <label for="name" class="col-xs-3 control-label">Email</label>
            <div class="col-xs-9">
              <input type="name" class="form-control" id="name" placeholder="World">
            </div>
          </div>
          <div class="form-group">
            <label for="language" class="col-xs-3 control-label">Language</label>
            <div class="col-xs-9">
              <select class="form-control" id="language">
                <option value="english">English</option>
                <option value="french">French</option>
                <option value="japanese">Japanese</option>
                <option value="spanish">Spanish</option>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
    <div class="row">
      <div class="col-xs-12 text-center" id="result">
      </div>
    </div>
  </div>
</body>
<script type="text/javascript">
  function fetchGreeting() {
    return $.ajax({
      url: "/greeting",
      method: "GET",
      data: {
        name: $("#name").val(),
        language: $($("#language")[0].selectedOptions).val()
      },
      success: function(greeting) {
        $("#result").text(greeting.content);
      },
      error: function (xhr) {
        $("#result").text(xhr.textStatus);
      }
    });
  };

  $(document).ready(function () {
    $("#language").val("english").on("change", fetchGreeting);
    $("#name").on("change", fetchGreeting);
    fetchGreeting();
  });
</script>
</html>