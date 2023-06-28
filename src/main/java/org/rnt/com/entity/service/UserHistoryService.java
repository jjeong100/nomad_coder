package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.UserHistoryVO;
import org.rnt.com.vo.RtnVO;

public interface UserHistoryService {
	public RtnVO insert(UserHistoryVO param);
	public RtnVO select(UserHistoryVO param);
	public RtnVO update(UserHistoryVO param);
	public RtnVO delete(UserHistoryVO param);
	public RtnVO searchList(UserHistoryVO param);
	public RtnVO searchListTotCnt(UserHistoryVO param);
	public RtnVO createHistory(UserHistoryVO param);
	public RtnVO selectListExcel(UserHistoryVO param);
	public RtnVO createLoginHistory(UserHistoryVO param);
	public RtnVO createTodayHistory(UserHistoryVO param);
	public RtnVO selectTodayHistoryList(UserHistoryVO param);
}
