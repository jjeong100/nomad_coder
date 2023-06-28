package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.rnt.com.entity.dao.ItemSubulDao;
import org.rnt.com.entity.vo.ItemSubulVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("itemSubulService")
public class ItemSubulServiceImpl extends BaseService implements ItemSubulService{

	@Resource(name="itemSubulDao")
	private ItemSubulDao itemSubulDao;
	
	@Override
	public RtnVO searchItemSubulList(ItemSubulVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemSubulDao.searchItemSubulList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchItemSubulListTotCnt(ItemSubulVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemSubulDao.searchItemSubulListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
