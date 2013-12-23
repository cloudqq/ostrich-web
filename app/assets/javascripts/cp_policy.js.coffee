# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#btn_create_new_policy_item").click ->
    $('#update_policy_item_form').attr('action','/cp_policy_item/submit_create');

    $('#modal_form_title').text("新增通道配置策略");
    $('#input_region').val()
    $('#input_region').attr("disabled",false)
    $('#input_mon_limit').val()
    $('#input_day_limit').val()
    $('#input_mon_phone_limit').val()
    $('#input_day_phone_limit').val()
    $('#input_discount_mon_limit').val()
    $('#input_discount_day_limit').val()
    $('#input_discount_base').val()
    $('#input_discount_start').val()
    $('#input_enabled').attr('checked',false)
    $('#city_list_container').empty()
    $('#input_region').change ->
      $('#city_list_container').empty()
      $.getJSON "/sys_info/get_cities/#{$(this).val()}", (data) ->
        for city_entry in data
          ul = $("<ul />")
          item=$('<div/>').addClass('tab_entry').html("<a href='#' onclick='add_to_selected_city_list(#{city_entry['ID']}, \"#{city_entry['CONTEXT']}\"); return false;'>#{city_entry['CONTEXT']}</a>")
          $('#city_list_container').append(item)      
    $('#input_region').trigger('change')
    $('#update_policy_item_modal').modal('show');
    return

@update_policy_item = (policy_item_id) ->
  $("#update_policy_item_form").attr("action", "/cp_policy_item/update/#{policy_item_id}")
  $('#modal_form_title').text("修改通道配置策略");
  $.getJSON "/cp_policy_item/get_data/#{policy_item_id}", (data) ->
    $('#input_region').val(data["SYS_INFO_ID"])
    $('#input_region').attr("disabled",true)
    $('#input_mon_limit').val(data["LIMITED_MON_MAX"])
    $('#input_day_limit').val(data["LIMITED_DAY_MAX"])
    $('#input_mon_phone_limit').val(data["LIMITED_MON_PHONE"])
    $('#input_day_phone_limit').val(data["LIMITED_DAY_PHONE"])
    $('#input_discount_mon_limit').val(data["DISCOUNT_MON_MAX"])
    $('#input_discount_day_limit').val(data["DISCOUNT_DAY_MAX"])
    $('#input_discount_base').val(data["DISCOUNT_BASE"])
    $('#input_discount_start').val(data["DISCOUNT_START"])
    if data["ENABLED"] == 1
      $('#input_enabled').attr('checked','checked')
    $.getJSON "/sys_info/get_cities/#{data['SYS_INFO_ID']}", (data) ->
      for city_entry in data
        ul = $("<ul />")
        item=$('<div/>').addClass('tab_entry').html("<a href='#' onclick='add_to_selected_city_list(#{city_entry['ID']}, \"#{city_entry['CONTEXT']}\"); return false;'>#{city_entry['CONTEXT']}</a>")
        $('#city_list_container').append(item)
    $.getJSON "/cp_policy_item/get_policy_cities", {policy_id: "#{data['POLICY_ID']}", parent_id: "#{policy_item_id}"}, (data) ->
      $('#city_selected_container > ul').empty()
      for city_entry in data
        item = $('<li/>').append('<a href=#></a>')
        $('a',item).append( $('<strong/>').html("#{city_entry['TARGET']}"))
        $('a',item).append("<input type='hidden' value=#{city_entry['ID']} name=cities[#{city_entry['TARGET']}]></input>")
        $('a',item).append('<b></b>').click ->
          $('#city_selected_container > ul > li').remove(":contains(\'#{city_entry['TARGET']}\')")
        $('#city_selected_container > ul').append(item)      
  $("#update_policy_item_modal").modal('show')
  return

@add_to_selected_city_list = (id, region) ->
  found = $('#city_selected_container > ul').find("li:contains(\'#{region}\')")
  if found.length > 0
    return
  item = $('<li/>').append('<a href=#></a>')
  $('a',item).append( $('<strong/>').html(region) )
  $('a',item).append("<input type='hidden' value=#{id} name=cities[#{region}]></input>")
  $('a',item).append('<b></b>').click ->
    $('#city_selected_container > ul > li').remove(":contains(\'#{region}\')")
  $('#city_selected_container > ul').append(item)
  
@create_policy_item = ->
  $("update_policy_item_modal").modal('show')
  return

@giveup = ()->
  history.back(1)
  

@load_policy_items = (server_params) ->
  options =
    column_names: ["省份","上限/月","上限/日","上限/号月","上线/号日","月扣","日扣","基数","起点","控制","操作"]
    url: "/cp_policy_item/list_for_table.json"
    paging: true
    server_params: server_params

  adv_options =
    aLengthMenu: [10,25,50]
    bSort:false
    oTableTools:
      aButtons:[
        sExtends: "create_new_sp_business_div"
        sButtonText: "新建通道"
        sDiv: "copy"
      ]
    aoColumnDefs:[
      {
        sWidth: "10%"
        aTargets:[0]
      },
      {
        sWidth: "8%"
        aTargets:[1]
      },
      {
        sWidth: "8%"
        aTargets:[2]
      },
      {
        sWidth: "10%"
        aTargets:[3]
      },
      {
        sWidth: "10%"
        aTargets:[4]
      },
      {
        sWidth: "10%"
        aTargets:[5]
      },
      {
        sWidth: "10%"
        aTargets:[6]
      },
      {
        sWidth: "8%"
        aTargets:[7]
      },
      {
        sWidth: "6%"
        aTargets:[8]
      },
      {
        sWidth: "8%"
        aTargets:[9]
        mRender:(data,type,row) ->
          if data == 1
            "开启"
          else
            "关闭"
      },
      {
        sWidth:"10%"
        aTargets:[10]
        mRender:(data,type,row) ->
          """
            <a class="btn btn-mini" href="#" onclick="update_policy_item(#{data.policy_item_id}); return false;">修改</a>
            <a class="btn btn-mini" href="/cp_policy_item/destroy/#{data.policy_item_id}">删除</a>
          """
      }
      
    ]
    aoColumns: [
      {
        aTargets:[0],
        mData: "target"
      },
      {
        aTargets:[1],
        mData: "limited_mon_max"
      },
      {
        aTargets:[2],
        mData: "limited_day_max"
      },
      {
        aTargets:[3],
        mData: "limited_mon_phone"
      },
      {
        aTargets:[4],
        mData: "limited_day_phone"
      },
      {
        aTargets:[5],
        mData: "discount_mon_max"
      },
      {
        aTargets:[6],
        mData: "discount_day_max"
      },
      {
        aTargets:[7],
        mData: "discount_base"
      },
      {
        aTargets:[8],
        mData: "discount_start"
      },
      {
        aTargets:[9],
        mData: "enabled"
      },
      {
        aTargets:[10],
        mData: (source,type,val) ->
          {
            policy_item_id : source.id
          }
      }
    ]
  $('#policy_data_table').easyTable options, adv_options


