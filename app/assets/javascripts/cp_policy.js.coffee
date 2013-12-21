# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

@giveup = ()->
  history.back(1)
  

@load_policy_items = (server_params) ->
  options =
    column_names: ["省份","上限/月","上限/日","上限/号月","上线/号日","月扣","日扣","基数","起点","控制"]
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
        sWidth: "14%"
        aTargets:[7]
      },
      {
        sWidth: "10%"
        aTargets:[8]
      },
      {
        sWidth: "8%"
        aTargets:[9]
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
      }
    ]
  $('#policy_data_table').easyTable options, adv_options


