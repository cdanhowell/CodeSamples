public class ParentApiResource implements IApiResource {


    public ParentApiResource() {

    }

    public Object get(Map<String, Object> queryParams) {
        // Going to completely mock this implementation for demonstration purposes...
        // Also going to use a simple map of integer => double to simulate the response. In a real app, this would likely
        // be better represnted with a POJO-like model instead

        return new Map<Integer, Double> {
            1 => 1.0,
            2 => 2.0,
            3 => 4.0
        };
    }
}
