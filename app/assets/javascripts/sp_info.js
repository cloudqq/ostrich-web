// Generated by CoffeeScript 1.6.2
(function() {
  var params, tool_option;

  params = {
    sNewLine: "<br>",
    sButtonText: "Copy to element",
    sDiv: "",
    fnClick: function(nButton, oConfig) {
      return $(window).attr("location", "/sp_info/create");
    }
  };

  TableTools.BUTTONS.create_new_sp_div = $.extend(true, TableTools.buttonBase, params);

  tool_option = {
    aButtons: [
      {
        sExtends: "create_new_sp_div",
        sButtonText: "新建SP",
        sDiv: "copy"
      }
    ]
  };

  jQuery(function() {
    var adv_options, options;

    options = {
      column_names: ["SP编号", "SP名称", "付款周期", "创建时间", "操作"],
      url: "/sp_info/list_for_table.json",
      paging: true,
      dom: "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    };
    adv_options = {
      aLengthMenu: [10, 25, 50],
      oTableTools: tool_option
    };
    return $("#xyz").easyTable(options, adv_options);
  });

}).call(this);
