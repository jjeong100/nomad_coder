package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.MenuAuthorVO;
import org.rnt.com.vo.RtnVO;

public interface MenuAuthorService {
	public RtnVO insert(MenuAuthorVO param);
	public RtnVO select(MenuAuthorVO param);
	public RtnVO update(MenuAuthorVO param);
	public RtnVO delete(MenuAuthorVO param);
	public RtnVO searchList(MenuAuthorVO param);
	public RtnVO searchListTotCnt(MenuAuthorVO param);
}
