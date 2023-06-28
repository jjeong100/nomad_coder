package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.FinishQmVO;
import org.rnt.com.vo.RtnVO;

public interface FinishQmService {
	public RtnVO insert(FinishQmVO param);
	public RtnVO select(FinishQmVO param);
	public RtnVO update(FinishQmVO param);
	public RtnVO delete(FinishQmVO param);
	public RtnVO searchList(FinishQmVO param);
	public RtnVO searchListTotCnt(FinishQmVO param);
	public RtnVO searchJoinList(FinishQmVO param);
	public RtnVO searchJoinListTotCnt(FinishQmVO param);
	public RtnVO getFinishQmListData(FinishQmVO param);
	public RtnVO getFinishQmListDataTotCnt(FinishQmVO param);
}
