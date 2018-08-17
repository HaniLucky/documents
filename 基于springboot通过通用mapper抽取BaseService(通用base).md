### 基于springboot通过通用mapper抽取BaseService(通用base)

##### BaseService

```
public interface BaseService<T> {
	/**
	 * 根据id查询数据
	 * 
	 * @param id
	 * @return
	 */
	public T queryById(Long id);

	/**
	 * 查询所有数据
	 * 
	 * @return
	 */
	public List<T> queryAll();

	/**
	 * 根据条件查询数据条数
	 * 
	 * @param t
	 * @return
	 */
	public Integer queryCountByWhere(T t);

	/**
	 * 根据条件查询数据
	 * 
	 * @param t
	 * @return
	 */
	public List<T> queryListByWhere(T t);

	/**
	 * 分页查询数据
	 * 
	 * @param page
	 * @param rows
	 * @return
	 */
	public List<T> queryByPage(Integer page, Integer rows);

	/**
	 * 根据条件查询一条数据
	 * 
	 * @param t
	 * @return
	 */
	public T queryOne(T t);

	/**
	 * 新增
	 * 
	 * @param t
	 * @return
	 */
	public void save(T t);

	/**
	 * 新增，忽略空参数
	 * 
	 * @param t
	 * @return
	 */
	public void saveSelective(T t);

	/**
	 * 根据主键更新
	 * 
	 * @param t
	 * @return
	 */
	public void updateById(T t);

	/**
	 * 根据主键更新，忽略空参数
	 * 
	 * @param t
	 * @return
	 */
	public void updateByIdSelective(T t);

	/**
	 * 根据id删除数据
	 * 
	 * @param id
	 * @return
	 */
	public void deleteById(Long id);

	/**
	 * 根据ids批量删除数据
	 * 
	 * @param ids
	 * @return
	 */
	public void deleteByIds(List<Object> ids);

}

```



##### BaseServiceImpl

```
public class BaseServiceImpl<T> implements BaseService<T> {

	@Autowired
	private Mapper<T> mapper;

	private Class<T> clazz;

	@SuppressWarnings("unchecked")
	public BaseServiceImpl() {
		// 获取父类的type
		Type type = this.getClass().getGenericSuperclass();

		// 强转为ParameterizedType，可以使用获取泛型类型的方法
		ParameterizedType pType = (ParameterizedType) type;

		// 获取泛型的class
		this.clazz = (Class<T>) pType.getActualTypeArguments()[0];
	}

	@Override
	public T queryById(Long id) {
		T t = this.mapper.selectByPrimaryKey(id);
		return t;
	}

	@Override
	public List<T> queryAll() {
		List<T> list = this.mapper.select(null);
		return list;
	}

	@Override
	public Integer queryCountByWhere(T t) {
		int count = this.mapper.selectCount(t);
		return count;
	}

	@Override
	public List<T> queryListByWhere(T t) {
		List<T> list = this.mapper.select(t);
		return list;
	}

	@Override
	public List<T> queryByPage(Integer page, Integer rows) {
		PageHelper.startPage(page, rows);

		List<T> list = this.mapper.select(null);

		return list;
	}

	@Override
	public T queryOne(T t) {
		T result = this.mapper.selectOne(t);
		return result;
	}

	@Override
	public void save(T t) {
		this.mapper.insert(t);
	}

	@Override
	public void saveSelective(T t) {
		this.mapper.insertSelective(t);
	}

	@Override
	public void updateById(T t) {
		this.mapper.updateByPrimaryKey(t);
	}

	@Override
	public void updateByIdSelective(T t) {
		this.mapper.updateByPrimaryKeySelective(t);
	}

	@Override
	public void deleteById(Long id) {
		this.mapper.deleteByPrimaryKey(id);
	}

	@Override
	public void deleteByIds(List<Object> ids) {
		// 声明条件
		Example example = new Example(this.clazz);
		example.createCriteria().andIn("id", ids);

		this.mapper.deleteByExample(example);
	}

}
```



##### 普通service

```
public interface TestService extends BaseService<Test>{
}

```



##### 普通serviceImpl

```
@Service
public class TestServiceImpl extends BaseServiceImpl<Test> implements TestService{
	
}
```



###### controller直接调用通用mapper中的方法即可,通用mapper大多只支持单表

可参考

[1].https://www.jianshu.com/p/4b4e75952e74 (介绍了基于springboot的通用mapper的通用base的抽取)