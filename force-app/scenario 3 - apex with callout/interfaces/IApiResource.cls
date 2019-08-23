public interface IApiResource {

    Object get(Map<String, Object> queryParams); // better to represent this with a more structured model when possible
    // other HTTP methods omitted for brevity
}
