A Lua script which naively tries to embed locally referenced files into an HTML page using [data URLs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URIs).

Usage:
```
lua dataurl.lua input.html output.html
```

Example input:
```lua
<html>
    <img src="image.png">
</html>
```

Example output:
```lua
<html>
    <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAADAQMAAABh+Fe7AAAABlBMVEX/AP////+fGDLgAAAADklEQVQI12MIYBBgCAAAAhYAsR0KavoAAAAASUVORK5CYII=" download="image.png">
</html>
```

This code is [public domain](https://creativecommons.org/publicdomain/zero/1.0/), please do whatever you want with it.
