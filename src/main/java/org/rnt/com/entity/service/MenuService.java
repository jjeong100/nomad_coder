package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.MenuVO;
import org.rnt.com.vo.RtnVO;

public interface MenuService {
	public RtnVO insert(MenuVO param);
	public RtnVO select(MenuVO param);
	public RtnVO update(MenuVO param);
	public RtnVO delete(MenuVO param);
	public RtnVO searchList(MenuVO param);
	public RtnVO searchListTotCnt(MenuVO param);
}
