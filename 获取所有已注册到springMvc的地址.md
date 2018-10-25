```
@RequestMapping("getAllUrl")
	public Set<String> getAllUrl(HttpServletRequest request) {
		Set<String> result = new HashSet<String>();
		WebApplicationContext wc = (WebApplicationContext) request
				.getAttribute(DispatcherServlet.WEB_APPLICATION_CONTEXT_ATTRIBUTE);
		RequestMappingHandlerMapping bean = wc.getBean(RequestMappingHandlerMapping.class);
		Map<RequestMappingInfo, HandlerMethod> handlerMethods = bean.getHandlerMethods();
		for (RequestMappingInfo rmi : handlerMethods.keySet()) {
			PatternsRequestCondition pc = rmi.getPatternsCondition();
			Set<String> pSet = pc.getPatterns();
			result.addAll(pSet);
		}
		return result;
	}
```

