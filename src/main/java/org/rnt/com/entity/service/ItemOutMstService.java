package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ItemOutMstVO;
import org.rnt.com.vo.RtnVO;

public interface ItemOutMstService {
	public RtnVO getSeq();
	public RtnVO insert(ItemOutMstVO param);
	public RtnVO select(ItemOutMstVO param);
	public RtnVO update(ItemOutMstVO param);
	public RtnVO delete(ItemOutMstVO param);
	public RtnVO searchList(ItemOutMstVO param);
	public RtnVO searchListTotCnt(ItemOutMstVO param);
	public RtnVO searchItemInList(ItemOutMstVO param);
	public RtnVO searchItemInListTotCnt(ItemOutMstVO param);
	public RtnVO searchMstList(ItemOutMstVO param);
    public RtnVO searchMstListTotCnt(ItemOutMstVO param);
	public RtnVO selectMstOut(ItemOutMstVO param);
	public RtnVO searchStorkQty(ItemOutMstVO param);
	public RtnVO searchItemOutList(ItemOutMstVO param);
	public RtnVO updateOutSet(ItemOutMstVO param);
	public RtnVO selectByLotId(ItemOutMstVO param);
}
