# PunchScrollView
[![Build Status](http://img.shields.io/travis/tapwork/PunchScrollView/master.svg?style=flat)](https://travis-ci.org/tapwork/PunchScrollView)
[![Cocoapods Version](http://img.shields.io/cocoapods/v/PunchScrollView.svg?style=flat)](https://github.com/tapwork/PunchScrollView/blob/master/PunchScrollView.podspec)
[![](http://img.shields.io/cocoapods/l/PunchScrollView.svg?style=flat)](https://github.com/tapwork/PunchScrollView/blob/master/LICENSE.md)
[![CocoaPods Platform](http://img.shields.io/cocoapods/p/PunchScrollView.svg?style=flat)]()

PunchScrollView is a little UIScrollView subclass for iOS which works like UICollectionView or UITableView Frameworks.
<br>

Easy and fast implementation: Delegate, DataSource methods and getter are similar to the UITableView's.
Use the benefits of the NSIndexPath pattern like you already know from the UITableView.
This allows an easy setup in combination with Core Data.

- Helpful methods, i.e. jump or scroll to a desired page
- Avoid boilerplate code
- Save lots of memory with the dequeuing
- Comes with an Example project to demonstrate the usage

Example setup in the ViewController

```  objective-c
self.scrollView = [[PunchScrollView alloc] init];
self.scrollView.delegate = self;
self.scrollView.dataSource = self;
self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
[self.view addSubview:self.scrollView];

#pragma mark - PunchScrollViewDataSource

- (NSInteger)numberOfSectionsInPunchScrollView:(PunchScrollView *)scrollView
{
	return 3;
}

- (NSInteger)punchscrollView:(PunchScrollView *)scrollView numberOfPagesInSection:(NSInteger)section
{
	return 3;
}

- (UIView*)punchScrollView:(PunchScrollView*)scrollView viewForPageAtIndexPath:(NSIndexPath *)indexPath
{
	ExamplePageView *page = (ExamplePageView*)[scrollView dequeueRecycledPage];
	if (page == nil)
	{
      //
      // You could also use PunchScrollview as gallery scrollview - just change the size of the desired view
      //
		page = [[ExamplePageView alloc] initWithFrame:self.view.bounds];
        page.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	}

	page.titleLabel.text = [NSString stringWithFormat:@"Page %d in section %d", indexPath.row, indexPath.section];

	return page;
}


```
