package org.rnt.material.service;

import org.rnt.com.vo.RtnVO;
import org.rnt.material.vo.MonthCloseInVO;
import org.rnt.material.vo.StockInVO;
import org.rnt.material.vo.SubulInVO;

public interface MaterialMenuService {
    //-------------------------------------------------------------------------
    // 재고 현황 : Stock
    //-------------------------------------------------------------------------
	public RtnVO searchStockList(StockInVO param);
	public RtnVO searchStockListTotCnt(StockInVO param);
	public RtnVO selectStockMatQtySum(StockInVO param);
	public RtnVO searchBaseQty(StockInVO param);
	//-------------------------------------------------------------------------
    // 수불 현황 : SuBul
    //-------------------------------------------------------------------------
	public RtnVO searchSubulList(SubulInVO param);
    public RtnVO searchSubulListTotCnt(SubulInVO param);

	//-------------------------------------------------------------------------
    // 월 마감 관리 : MonthClose
    //-------------------------------------------------------------------------
    public RtnVO searchMonthCloseList(MonthCloseInVO param);
    public RtnVO searchMonthCloseListTotCnt(MonthCloseInVO param);
    public RtnVO selectMinUnCloseMonth(MonthCloseInVO param);
    public RtnVO selectMaxCloseMonth(MonthCloseInVO param);
    public RtnVO selectMaxCloseMonthAndDiffMonth(MonthCloseInVO param);


}
