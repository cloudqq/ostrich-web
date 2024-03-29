# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


@list_cp_info_table = ->
  options =
    table_id: "tb_cp_info"
    column_names: ["CP编号","登录账号","真实名称","状态","接入时间","操作"]
    url: "/cp_info/list_for_table.json"
    paging: true
  adv_options =
    aLengthMenu: [10,25,50]
    bSort:false    
    aoColumnDefs:[
                  {
                    sWidth:"10%"
                    aTargets:[0]
                  },
                  {
                    sWidth:"20%"
                    aTargets:[1]
                  },
                  {
                    sWidth:"30%"
                    aTargets:[2]
                  },
                  {
                    sWidth:"10%"
                    aTargets:[3]
                    mRender:(data,type,row) ->
                      if data == 1
                        "正常"
                      else
                        "关闭"
                  },
                  {
                    sWidth:"10%"
                    aTargets:[4]
                  },
                  {
                    sWidth:"20%"
                    aTargets:[5]
                    mRender: (data,type,row) ->
                      data = """
                              <a href=/cp_info/configure/#{data.cpid}>编辑</a> |
                              <a href=/cp_info/change_password/#{data.cpid}>密码</a> |
                              <a href=/cp_info/assignment?cpid=#{data.cpid}>分配</a> |
                              <a href=/cp_info/province/#{data.cpid}>省份</a>
                             """
                  },                                                                                            
                ],
                aoColumns:[
                  null,
                  null,
                  null,
                  null,
                  null,
                  mData: (source,type,val) ->
                    {
                      cpid: source[0],
                      cpname: source[5]
                    }
                 ]
  $("#cp_info_table").easyTable options, adv_options

@create_business = (index,spid,cpid,sp_business_id) ->
  ###
   sp_business_id not SPID
  ###
  cmd = ""
  rowObj = $("#tb_cmd_assignment tr:eq(#{index+1})")
  cmdObj = $("td:eq(3) input", rowObj)
  if cmdObj.length
    cmd = cmdObj.val()
  pay_percent = $("td:eq(4) input",rowObj).val()
  dis_percent = $("td:eq(5) input",rowObj).val()
  create_business_url = "/cp_business/create?cpid=#{cpid}&spid=#{spid}&c=#{cmd}&pp=#{pay_percent}&dp=#{dis_percent}&spuid=#{sp_business_id}"
  $.ajax
    url: "/cp_business/occupied"
    type: "GET"
    dataType: "json"
    data:
      spid: spid
      cmd: cmd
    success: ->
      $(location).attr('href',create_business_url)  
    error: (xhr,error,thrown) ->
      html = """
              <div class="alert alert-error">
                <button type="button" class="close" data-dismiss="alert">x</button>
                指令已经存在，请重新选择扩展指令
              </div>
             """
      $("#cmd_assignment_table").before(html)
    
@list_cmd_assignment_table = (server_params,cpid) ->
        params =
          sNewLine: "<br>"
          sButtonText: "Copy to element"
          sDiv: ""
          fnClick: (nButton, oConfig) ->
            $(window).attr("location", "/cp_info/create")
                
        TableTools.BUTTONS.create_new_cp_info_div = $.extend true, TableTools.buttonBase, params
  
        tb_cmd_assignment_row_callback = (nRow,aData,iDisplayIndex, iDisplayIndexFull) ->
                  ###
                  aData
                  ~~~~~~~~~~~~~~~~~
                  spname
                  spnumber
                  cmd
                  ''
                  0
                  0
                  arealist
                  cmdtype
                  spid
                  id

                  create_business(rowid, spid, cpid, sp_business_uid)
                  ###
                  cmdObj = $("td:eq(3) input", nRow)
                  cmd = ""
                  if cmdObj.length
                    cmd = cmdObj.val()
                  html = """
                         <a href=# onclick="javascript:create_business(#{iDisplayIndex},#{aData.spid},#{cpid},#{aData.id}); return false;">分配</a>
                         """
                  $("td:eq(7)",nRow).html(html)
        options =
                table_id: "tb_cmd_assignment"
                column_names:["SP名称","特服号","指令","扩展","结算","扣量","通道概要","操作"]
                url: "/cp_info/list_for_assignment_table.json"
                paging: true
        adv_options =
                fnRowCallback: tb_cmd_assignment_row_callback
                aLengthMenu: [10,25,50]
                bSort: false
                oTableTools:
                  aButtons:[
                    sExtends: "create_new_cp_info_div"
                    sButtonText:"创建CP"
                    sDiv: "copy"
                  ]
                aoColumnDefs: [
                        {
                          sWidth: "24%"
                          aTargets:[0]
                        },
                        {
                          sWidth: "14%"
                          aTargets:[1]
                        },
                        {
                          sWidth: "10%"
                          aTargets:[2]
                        },
                        {
                                sWidth: "10%"
                                mRender: (data,type,row) ->
                                        if data == 1
                                                return '<input type="text" class="input-block-level"></input>'
                                        else
                                                return ''
                                aTargets: [3]
                        },
                        {
                                sWidth: "6%"
                                mRender: (data,type,row) ->
                                  return '<input type="text" class="input-block-level" value="100"></input>'
                                aTargets: [4]
                        },
                        {
                          sWidth: "6%" 
                          mRender:(data,type,row) ->
                            return '<input type="text" class="input-block-level" value="0"></input>'
                          aTargets: [5]
                        },
                        {
                          sWidth:"20%",
                          aTargets:[6]
                        },
                        {
                          sWidth:"10%",
                          aTargets:[7]
                        }
                ]
                aoColumns:[
                        {
                          aTargets:[0]
                          mData: 'spname'
                        },
                        {
                          aTargets:[1]
                          mData: 'spnumber'
                        },
                        {
                          aTargets:[2]
                          mData: 'cmd'
                        },
                        {
                          aTargets:[3]
                          mData: (source,type,val) -> 
                                source.cmdtype
                        },                                                 
                        {
                          aTargets:[4]
                          mData: (source, type, val) ->
                            ""
                        },
                        {
                          aTargets:[5]
                          mData: (source, type,val) ->
                            ""
                        },  
                        {
                          aTargets:[6]
                          mData: 'arealist'
                        },
                        {
                          aTargets:[7]
                          mData: (source, type, val) ->
                            ""
                        }
                ]
        $("#cmd_assignment_table").easyTable options, adv_options
                

@load_cp_province =  (cp_id) ->
  params = [{name: 'cp_id', value: "#{cp_id}"}]
  options =
    table_id: "tb_cp_info"
    column_names: ["省份","日总量","月总量","手机单日","手机单月","特服号","指令","状态", "最后更新"]
    url: "/cp_info/province_for_table.json"
    paging: true
    server_params: params
  adv_options =
    aLengthMenu: [10,25,50]
    bSort:false    
    aoColumnDefs:[
                  {
                    sWidth:"10%"
                    aTargets:[0]
                  },
                  {
                    sWidth:"10%"
                    aTargets:[1]
                  },
                  {
                    sWidth:"10%"
                    aTargets:[2]
                  },
                  {
                    sWidth:"10%"
                    aTargets:[3]
                  },
                  {
                    sWidth:"10%"
                    aTargets:[4]
                  },
                  {
                    sWidth:"10%"
                    aTargets:[5]
                  },
                  {
                    sWidth:"10%"
                    aTargets:[7]
                    mRender:(data,type,row) ->
                      if data == 1
                        "开放"
                      else
                        "关闭"
                  }
                ],
                aoColumns:[
                  {
                    aTargets:[0]
                    mData: 'target'
                    
                  },
                  {
                    aTargets:[1]
                    mData:'limited_day_max'
                  },
                  {
                    aTargets:[2]
                    mData:'limited_mon_max'
                  },
                  {
                    aTargets:[3]
                    mData:'limited_day_phone'
                  },                                    
                  {
                    aTargets:[4]
                    mData:'limited_mon_phone'
                  },                                    
                  {
                    mData:'spnumber'
                  },
                  {
                    mData:'cmd'
                  },
                  {
                    mData:'enabled'
                  },
                  {
                    mData:'updated_at'
                  }
                 ]
  $("#cp_province_table").easyTable options, adv_options  
