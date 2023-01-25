
************
Lazy loading
************
    Application requests data from elastic cache, gets a cache hit and returns the data
    Application requests data from elastic cache, gets a cache miss. It then makes a read request from the 
    data-base. It then writes the data back in the cache. This means three network calls causing latency to
    users. During cache hit, you might get stale data.
*************
Write through
*************
    Application requests data from elastic cache, gets a cache hit and returns the data
    Application receives a write request and writes through DB and elastc cache
    Cache data is never stale
    Writing data to elastic cache can become huge, use Time-To-Live to delete cached data