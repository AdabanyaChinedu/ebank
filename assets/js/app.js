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
  var table = $("#body")
    .DataTable({
      responsive: true,
      data: "",
      pagingType: "simple",
      dom: '<"top"fip>rt<"clear">',
      language: { search: "" },
      pageLength: 15,
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
  $("#body_next").append("<i id='next-btn' class='icon icon-arrow-right'></i>");
  $("#total").text(resultArray.length);
  $(".dyn-btn2").click(function() {
    window.location.href = "/tickets/new";
  });
});


    // const axios = require("axios");

    // axios({       
    //   method: "get",
    //   url: "/api/transactionns",
    //   responseType: "json"
    // }).then(function(response) {
    //   var apiresponse = response.data;

    //   var resultArray = [];

    //   for (let i = 0; i <= apiresponse.length - 1; i++) {
    //     resultArray.push([
    //       "<a href=/tickets/" +
    //         apiresponse[i].id +
    //         ">" +
    //         apiresponse[i].ref_no +
    //         "</a>",
    //       apiresponse[i].subject,
    //       apiresponse[i].email,
    //       apiresponse[i].assignee,
    //       "<span id='status'>" + apiresponse[i].status + "</span>",
    //       apiresponse[i].inserted_at.substr(0, 10)
    //     ]);
    //   }

    //   var table = $("#body")
    //     .DataTable({
    //       responsive: true,
    //       data: resultArray,
    //       pagingType: "simple",
    //       dom: '<"top"fip>rt<"clear">',
    //       language: { search: "" },
    //       pageLength: 15,
    //       columnDefs: [{ className: "", targets: "_all" }]
    //     })
    //     .columns.adjust()
    //     .responsive.recalc();

    //   $(".dataTables_filter input").attr("placeholder", "Search");
    //   $.fn.DataTable.ext.pager.numbers_length = 4;

  




