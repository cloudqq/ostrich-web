# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
jQuery ->
  $("#btn_create_new_sp_policy_item").click ->
    $('#update_policy_item_form').attr('action','/sp_policy_item/submit_create');

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
  $("#update_policy_item_form").attr("action", "/sp_policy_item/update/#{policy_item_id}")
  $('#modal_form_title').text("修改通道配置策略");
  $.getJSON "/sp_policy_item/get_data/#{policy_item_id}", (data) ->
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
    $.getJSON "/sp_policy_item/get_policy_cities", {policy_id: "#{data['POLICY_ID']}", parent_id: "#{policy_item_id}"}, (data) ->
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

@update_twice_mt = (policy_item_id) ->
  $("#update_twice_mt_modal").modal('show')

@load_sp_policy_items = (server_params) ->
  options =
  column_names: ["省份","月总量","日总量","手机日限","手机月限","类型","状态","操作"]
  url: "/sp_policy_item/list_for_table.json"
  paging: true
  server_params: server_params

  adv_options =
    aLengthMenu: [10,25,50]
    bSort:false
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
        sWidth: "6%"
        aTargets:[5]
        mRender:(data, type,row) ->
          switch row.twice_type
            when 0 then "普通"
            when 1 then "回复任意"
            when 2 then "回复待定"
            when 3 then "智能问答"
            else "未知"
      },
      {
        sWidth: "8%"
        aTargets:[6]
        mRender:(data,type,row) ->
          if data == 1
            "开启"
          else
            "关闭"
      },
      {
        sWidth:"10%"
        aTargets:[7]
        mRender:(data,type,row) ->
          """
            <a class="btn btn-mini" href="#" onclick="update_policy_item(#{data.policy_item_id}); return false;">修改</a>
            <a class="btn btn-mini" href="/sp_policy_item/destroy/#{data.policy_item_id}">删除</a>
            <a class="btn btn-mini" href="#" onclick="update_twice_mt(#{data.policy_item_id}); return false;">二次</a>
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
        mData: "twice_type"
      },
      {
        aTargets:[6],
        mData: "enabled"
      },
      {
        aTargets:[7],
        mData: (source,type,val) ->
          {
            policy_item_id : source.id
          }
      }
    ]
  $('#sp_policy_data_table').easyTable options, adv_options
