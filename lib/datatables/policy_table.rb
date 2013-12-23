# -*- coding: utf-8 -*-
require File.expand_path('../datatable_base',__FILE__)

module Datatable
  class PolicyTable
    delegate :params, :h, :link_to, :number_to_currency, to: :@view
    attr_accessor :total_count

    def initialize(view)
      @view = view
    end

    def data
      result = []
      fetch_data.each do |x|
        result <<
          {
            id: x.ID,
            policy_id: x.POLICY_ID,
            parent_id: x.PARENT_ID,
            target: x.TARGET,
            hash: x.HASH,
            enabled: x.ENABLED,
            limited_day_max: x.LIMITED_DAY_MAX,
            limited_mon_max: x.LIMITED_MON_MAX,
            limited_day_phone: x.LIMITED_DAY_PHONE,
            limited_mon_phone: x.LIMITED_MON_PHONE,
            discount_day_max: x.DISCOUNT_DAY_MAX,
            discount_mon_max: x.DISCOUNT_MON_MAX,
            discount_base: x.DISCOUNT_BASE,
            discount_start: x.DISCOUNT_START,
            created_at: x.CREATED_AT,
            updated_at: x.UPDATED_AT
          }
      end
      result
    end

    def fetch_data
      conditions = " 1=1 AND CP_POLICY_ITEMS.PURGED = 0 AND PARENT_ID=0"
      conditions << " AND CP_POLICY_ITEMS.POLICY_ID = #{params[:policy_id]} " unless params[:policy_id].blank?

      fields = %w(
                   CP_POLICY_ITEMS.ID
                   CP_POLICY_ITEMS.POLICY_ID
                   CP_POLICY_ITEMS.PARENT_ID
                   CP_POLICY_ITEMS.TARGET
                   CP_POLICY_ITEMS.HASH
                   CP_POLICY_ITEMS.ENABLED
                   CP_POLICY_ITEMS.LIMITED_DAY_MAX
                   CP_POLICY_ITEMS.LIMITED_MON_MAX
                   CP_POLICY_ITEMS.LIMITED_DAY_PHONE
                   CP_POLICY_ITEMS.LIMITED_MON_PHONE
                   CP_POLICY_ITEMS.DISCOUNT_DAY_MAX
                   CP_POLICY_ITEMS.DISCOUNT_MON_MAX
                   CP_POLICY_ITEMS.DISCOUNT_BASE
                   CP_POLICY_ITEMS.DISCOUNT_START
                   CP_POLICY_ITEMS.CREATED_AT
                   CP_POLICY_ITEMS.UPDATED_AT
                 )

      self.total_count = CpPolicyItem.select(fields).joins(:policy).where(conditions).count
      records = CpPolicyItem.select(fields).joins(:policy).where(conditions)
        .page(page)
        .per_page(per_page)
    end

    def as_json(options = {})
      mydata = data
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecord: self.total_count,
        iTotalDisplayRecords: self.total_count,
        aaData: mydata
      }
    end

    private
    include DataTableBase
  end
end

