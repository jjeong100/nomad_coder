package org.rnt.com.entity.service;

import javax.annotation.Resource;

import org.jfree.util.Log;
import org.rnt.com.entity.dao.ItemOutDtlDao;
import org.rnt.com.entity.dao.ItemOutMstDao;
import org.rnt.com.entity.vo.ItemOutMstVO;
import org.rnt.com.service.BaseService;
import org.rnt.com.vo.RtnVO;
import org.springframework.stereotype.Service;

@Service("itemOutMstService")
public class ItemOutMstServiceImpl extends BaseService implements ItemOutMstService{

	@Resource(name="itemOutMstDao")
	private ItemOutMstDao itemOutMstDao;

	@Resource(name="itemOutDtlDao")
	private ItemOutDtlDao itemOutDtlDao;

	@Override
	public RtnVO getSeq() {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.getSeq();
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO insert(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			param.setItemoutSeq((String)itemOutMstDao.getSeq().getObj());
			if("".equals(param.getLotOutId()) || param.getLotOutId()==null) {
				System.out.print("테스트");
			param.setLotOutId((String)itemOutMstDao.getLotId().getObj());
			}
			rtn = itemOutMstDao.insert(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO select(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.select(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO update(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.update(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO delete(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.delete(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchList(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.searchList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchListTotCnt(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.searchListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchItemInList(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.searchItemInList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO searchItemInListTotCnt(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.searchItemInListTotCnt(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
    public RtnVO searchMstList(ItemOutMstVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = itemOutMstDao.searchMstList(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }

    @Override
    public RtnVO searchMstListTotCnt(ItemOutMstVO param) {
        RtnVO rtn = new RtnVO();
        try {
            rtn = itemOutMstDao.searchMstListTotCnt(param);
        } catch (Exception e) {
            setRtnVO(rtn, null, e.getMessage());
        }
        return rtn;
    }
    @Override
    public RtnVO selectMstOut(ItemOutMstVO param) {
    	RtnVO rtn = new RtnVO();
    	try {
    		rtn = itemOutMstDao.selectMstOut(param);
    	} catch (Exception e) {
    		setRtnVO(rtn, null, e.getMessage());
    	}
    	return rtn;
    }
    @Override
    public RtnVO searchStorkQty(ItemOutMstVO param) {
    	RtnVO rtn = new RtnVO();
    	try {
    		rtn = itemOutMstDao.searchStorkQty(param);
    	} catch (Exception e) {
    		setRtnVO(rtn, null, e.getMessage());
    	}
    	return rtn;
    }

    @Override
	public RtnVO searchItemOutList(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.searchItemOutList(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO updateOutSet(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.updateOutSet(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}

	@Override
	public RtnVO selectByLotId(ItemOutMstVO param) {
		RtnVO rtn = new RtnVO();
		try {
			rtn = itemOutMstDao.selectByLotId(param);
		} catch (Exception e) {
			setRtnVO(rtn, null, e.getMessage());
		}
		return rtn;
	}
}
