# MSLoadMore
A sample code for iOS to lazy load more items in UITableView.

This is a sample to load more data to a tableview by scrolling to the end of table and then it requests to load more data.

In viewDidLoad() we ask for a portion of data with a predefined offset and count, and each time UITableView scroll reaches end of the table, we check whether it needs to load more data or not; if so, we continue by calling loadMoreData() method to add more data to our table.

Feel free to improve or update the code.
