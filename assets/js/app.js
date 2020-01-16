// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

$(document).ready(function() {
  if (window.location.href.endsWith("/transactions/new")) {
    $("#home-icon").removeClass("active");
    $("#transfer-arrow").addClass("active");
   
  } else {
    $("#transfer-arrow").removeClass("active");
    $("#home-icon").addClass("active");

  }

  $("#account-toggle").change(function() {
    var selectedAcccount = $("#account-toggle")
      .find(":selected")
      .text();
    if (selectedAcccount.indexOf("Current") >= 0) {
      axiosCall("current");
    }
    if (selectedAcccount.indexOf("Savings") >= 0) {
      axiosCall("savings");
    }
  });

  const axios = require("axios");

  function axiosCall(accountType) {
    return axios({
      method: "get",
      url: "/api/transactions",
      responseType: "json"
    }).then(function(response) {
      //where account type is savings

      var customerInfo = response.data.data;
      var accounts = customerInfo.accounts;
      //var transactions = accounts[0].transactions;

      var savingsAccount = accounts.filter(
        account => account.account_type == "savings"
      );

      var currentAccount = accounts.filter(
        account => account.account_type == "current"
      );
      var stransactions;
      var ctransactions;

      if (accountType) {
        if (accountType == "savings") {
          stransactions = savingsAccount[0].transactions;
          // ctransctions = [];
        } else {
          ctransactions = currentAccount[0].transactions;
          // stransctions = [];
        }
      } else {
        if (savingsAccount.length > 0) {
          stransactions = savingsAccount[0].transactions;

          $("#account-toggle").append(
            "<option id='s-option'>Savings - " +
              savingsAccount[0].account_number +
              "</option>"
          );
        }
        if (currentAccount.length > 0) {
          ctransactions = currentAccount[0].transactions;

          $("#account-toggle").append(
            "<option id='c-option'>Current - " +
              currentAccount[0].account_number +
              "</option>"
          );
        }
      }

      if (stransactions) {
        $("#c-balance").text(savingsAccount[0].current_balance);
        $("#a-balance").text(savingsAccount[0].available_balance);
      } else {
        $("#c-balance").text(currentAccount[0].current_balance);
        $("#a-balance").text(currentAccount[0].available_balance);
      }
      var apiresponse = stransactions || ctransactions;

      var resultArray = [];

      for (let i = 0; i <= apiresponse.length - 1; i++) {
        resultArray.push([
          "<a href=/transactions/" +
            apiresponse[i].id +
            ">" +
            apiresponse[i].id +
            "</a>",
          apiresponse[i].description,
          apiresponse[i].debit_credit,
          apiresponse[i].available_balance,
          "<span id='status'>" + apiresponse[i].status + "</span>",
          apiresponse[i].created.substr(0, 10)
        ]);
      }

      $("#body")
        .DataTable({
          responsive: true,
          data: resultArray,
          pagingType: "simple",
          dom: '<"top"fip>rt<"clear">',
          language: { search: "" },
          pageLength: 15,
          bDestroy: true,
          columnDefs: [{ className: "", targets: "_all" }]
        })
        .columns.adjust()
        .responsive.recalc();

      $(".dataTables_filter input").attr(
        "placeholder",
        "Search for transaction ID"
      );

      $.fn.DataTable.ext.pager.numbers_length = 4;

      $(".previous").html("");
      $(".next").html("");

      $("#body_previous").addClass("btn");
      $("#body_next").addClass("btn");
      $("#body_info").text(function(index, text) {
        return text
          .replace("Showing", "Viewing")
          .replace("to", "-")
          .replace("entries", "");
      });
      $("#body_filter").after(
        "<button id='filter-btn' class='dyn dyn-btn1 btn'>Filter <i id='filter-drpdn' class='icon icon-arrow-down'></i></button>"
      );
      $("#body_previous").append(
        "<i id='prev-btn' class='icon icon-arrow-left'></i>"
      );
      $("#body_next").append(
        "<i id='next-btn' class='icon icon-arrow-right'></i>"
      );
      // $("#total").text(resultArray.length);
    });
  }
  axiosCall("");

  // $(".dyn-btn2").click(function(e) {
  //   window.location.href = "/tickets/new";
  // });

  $("#transfer-arrow").click(function(e) {
    window.location.href = "/transactions/new";
  });

  $("#home-icon").click(function(e) {
    window.location.href = "/transactions";
  });

  $("#go-back").click(function(e) {
    window.location.href = "/transactions";
  });
});
