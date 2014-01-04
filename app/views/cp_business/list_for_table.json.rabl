node do
  {
    'sEcho' => @extra,
    'iTotalRecords' => @business.count,
    'iTotalDisplayRecords' => @business.count,
  }
end
node :aaData do
  @business.map do |u|
    attribute :spname => u.spinfo.SPNAME,
              :cpname => u.cpinfo.CPNAME,
              :spnumber => u.SPNUMBER,
              :cmd => u.CMD,
              :cmdtype => u.CMDTYPE,
              :price => u.PRICE,
              :pay_percent => u.PAYPRCT,
              :dis_percent => u.DISCOUNTPRCT,
              :status => u.STATUS,
              :createtime => u.CREATETIME.strftime("%Y-%m-%d"),
              :options => "",
              :interfaceurl => u.INTERFACEURL,
              :report_valid => u.REPORTVALID,
              :request_method => u.REQUESTMETHOD,
              :url_template => u.URLTEMPLATE,
              :cpid => u.CPID,
              :spid => u.SPID,
              :id => u.ID,
              :policyid => u.POLICY_ID,
              :offline => u.OFFLINE
  end
end

