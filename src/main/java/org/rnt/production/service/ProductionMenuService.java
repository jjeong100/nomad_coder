package org.rnt.production.service;

import org.rnt.com.entity.vo.ProductionMstActVO;
import org.rnt.com.vo.RtnVO;
import org.rnt.material.vo.MonthCloseInVO;
import org.rnt.material.vo.StockInVO;

public interface ProductionMenuService {
	public RtnVO productionOperList(ProductionMstActVO param);
	
	//-------------------------------------------------------------------------
    // 월 마감 관리 : MonthClose
    //-------------------------------------------------------------------------
    public RtnVO searchMonthCloseList(MonthCloseInVO param);
    public RtnVO searchMonthCloseListTotCnt(MonthCloseInVO param);
    public RtnVO selectMinUnCloseMonth(MonthCloseInVO param);
    public RtnVO selectMaxCloseMonth(MonthCloseInVO param);
    public RtnVO selectMaxCloseMonthAndDiffMonth(MonthCloseInVO param);
}
