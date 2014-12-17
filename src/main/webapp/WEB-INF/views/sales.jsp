<%@ page language="java" contentType="text/html;charset=ISO-8859-1"%>
<html>
<head>
  <title>Sales Demo</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
  <link href='http://fonts.googleapis.com/css?family=Average+Sans' rel='stylesheet' type='text/css'>
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
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
            Specify the information below
          </strong>
        </h2>
      </div>
    </div>
    <hr/>
    <div class="row">
      <div class="col-md-3 col-xs-6">
        <div class="checkbox">
          <label>
            <input type="checkbox" id="is-active" value="true">
            Active
          </label>
        </div>
      </div>

      <div class="col-md-3 col-xs-6">
        <div class="radio">
          <label>
            <input type="radio" name="roleRadios" id="producerOption" value="producer" checked>
            Producer
          </label>
        </div>
        <div class="radio">
          <label>
            <input type="radio" name="roleRadios" id="managerOption" value="manager">
            Manager
          </label>
        </div>
      </div>

      <div class="col-md-3 col-xs-6">
        <div class="pull-right">
          <div class="radio">
            <label>
              <input type="radio" name="channelRadios" id="csOption" value="cs" checked>
              Care Solutions
            </label>
          </div>
          <div class="radio">
            <label>
              <input type="radio" name="channelRadios" id="retailOption" value="retail">
              Retail
            </label>
          </div>
        </div>
      </div>

      <div class="col-md-3 col-xs-6">
        <button id="apply" type="button" style="margin-top: .5em;" class="btn btn-lg btn-primary pull-right">Apply</button>
      </div>
    </div>
    <hr/>
  </div>
  <nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
          <li class="dropdown">
            <a href="javascript:void(0)" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Products <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li class="all-products"><a href="javascript:void(0)">Term</a></li>
              <li class="all-products"><a href="javascript:void(0)">Whole Life</a></li>
              <li class="all-products"><a href="javascript:void(0)">Universal Life</a></li>
              <li class="all-products"><a href="javascript:void(0)">Annuities</a></li>
              <li class="all-products cs-products"><a href="javascript:void(0)">Care Solutions</a></li>
              <li class="all-products"><a href="javascript:void(0)">Disability Income</a></li>
              <li class="all-products"><a href="javascript:void(0)">Additional Products</a></li>
              <li class="all-products"><a href="javascript:void(0)">Service only Products</a></li>
              <li class="all-products"><a href="javascript:void(0)">State Approvals</a></li>
              <li class="all-products"><a href="javascript:void(0)">Life Insurance Riders</a></li>
              <li class="all-products"><a href="javascript:void(0)">Investments</a></li>
            </ul>
          </li>
          <li><a href="javascript:void(0)" class="disabled" style="pointer-events: none;cursor: default;" disabled>Selling Resources</a></li>
        </ul>
      </div>
    </div>
  </nav>
  <div class="container">
    <div id="new-business" class="row">
      <h3>New Business</h3>
      <ul>
        <li class="all-products"><strong>Case #19922</strong>: <em>Universal Life</em> with Steve Martin</li>
        <li class="all-products"><strong>Case #21123</strong>: <em>Additional Products</em> with Ashton Kutcher</li>
        <li class="all-products cs-products"><strong>Case #98006</strong>: <em>Care Solutions</em> with Whoopie Goldberg</li>
      </ul>
    </div>
    <div id="oas-activity" class="row">
      <h3>OAS Activity</h3>
      <ul>
        <li><strong>LEET</strong>: <span style="color: green;">&#x2191; 3%</span></li>
        <li><strong>HCKR</strong>: <span style="color: red;">&#x2193; 4%</span></li>
        <li><strong>SKLZ</strong>: <span style="color: green;">&#x2191; 1%</span></li>
      </ul>
    </div>
    <div id="user-list" class="row">
      <h3>Users</h3>
      <ul>
        <li><strong>Marvin the Martian</strong>: $210</li>
        <li><strong>Bugs Bunny</strong>: $370</li>
        <li><strong>Daffy Duck</strong>: $290</li>
      </ul>
    </div>
    <div id="commission-info" class="row">
      <h3>Recent Commissions</h3>
      <ul>
        <li><strong>Harry Kim</strong>: $70</li>
        <li><strong>Neelix</strong>: $390</li>
        <li><strong>B'elanna Torres</strong>: $150</li>
      </ul>
    </div>
  </div>
</body>

<script type="text/javascript">
  function fetchContent() {
    $(".all-products").hide();
    $("#new-business").hide();
    $("#oas-activity").hide();
    $("#user-list").hide();
    $("#commission-info").hide();
    return $.ajax({
      url: "sales",
      method: "GET",
      data: {
        role: $('input[name="roleRadios"]:checked').val(),
        channel: $('input[name="channelRadios"]:checked').val(),
        status: $("#is-active")[0].checked
      },
      success: function(data) {
        if (data.showAllProducts) {
          $(".all-products").show();
        }

        if (data.showCsProducts) {
          $(".cs-products").show();
        }

        if (data.showNewBusiness) {
          $("#new-business").show();
        }

        if (data.showOasActivity) {
          $("#oas-activity").show();
        }

        if (data.showUserList) {
          $("#user-list").show();
        }

        if (data.showCommissionInfo) {
          $("#commission-info").show();
        }
      },
      error: function (xhr) {
        $("#result").text(xhr.textStatus);
      }
    });
  };

  $(document).ready(function () {
    $("#apply").on("click", fetchContent);
    fetchContent();
  });
</script>
</html>