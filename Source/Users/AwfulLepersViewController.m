//
//  AwfulLepersViewController.m
//  Awful
//
//  Created by me on 1/29/13.
//  Copyright (c) 2013 Regular Berry Software LLC. All rights reserved.
//

#import "AwfulLepersViewController.h"
#import "AwfulAlertView.h"
#import "AwfulHTTPClient.h"
#import "AwfulLeperCell.h"
#import "AwfulThreadTags.h"

@interface AwfulLepersViewController ()

@property (nonatomic) NSInteger currentPage;

@property (nonatomic) NSMutableArray *bans;

@end


@implementation AwfulLepersViewController

- (id)init
{
    if (!(self = [super initWithStyle:UITableViewStylePlain])) return nil;
    self.title = @"Leper's Colony";
    _bans = [NSMutableArray new];
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

#pragma mark - AwfulTableViewController

- (void)refresh
{
    [super refresh];
    [self loadPageNum:1];
}

- (BOOL)refreshOnAppear
{
    return [self.bans count] == 0;
}

- (BOOL)canPullForNextPage
{
    return YES;
}

- (void)loadPageNum:(NSUInteger)pageNum
{
    [self.networkOperation cancel];
    __block id op;
    op = [[AwfulHTTPClient client] listBansOnPage:pageNum
                                             andThen:^(NSError *error, NSArray *bans)
    {
        if (![self.networkOperation isEqual:op]) return;
        if (error) {
            [AwfulAlertView showWithTitle:@"Network Error" error:error buttonTitle:@"OK"];
        } else {
            self.currentPage = pageNum;
            if (pageNum == 1) {
                self.bans = [bans mutableCopy];
                [self.tableView reloadData];
            } else {
                [self.bans addObjectsFromArray:bans];
                NSMutableArray *indexPaths = [NSMutableArray new];
                NSUInteger start = [self.tableView numberOfRowsInSection:0];
                NSUInteger end = start + [bans count];
                for (NSUInteger i = start; i < end; i++) {
                    [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                }
                [self.tableView insertRowsAtIndexPaths:indexPaths
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
        self.refreshing = NO;
    }];
    self.networkOperation = op;
}

- (void)nextPage
{
    [super nextPage];
    [self loadPageNum:self.currentPage + 1];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bans count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const Identifier = @"LeperCell";
    AwfulLeperCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[AwfulLeperCell alloc] initWithReuseIdentifier:Identifier];
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AwfulLeperCell heightWithBan:self.bans[indexPath.row] inTableView:tableView];
}

- (void)configureCell:(UITableViewCell *)baseCell atIndexPath:(NSIndexPath *)indexPath
{
    AwfulLeperCell *cell = (id)baseCell;
    BanParsedInfo *ban = self.bans[indexPath.row];
    
    cell.textLabel.text = ban.bannedUserName;
    cell.detailTextLabel.text = ban.banReason;
    
    if (ban.postID) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.imageView.image = [[AwfulThreadTags sharedThreadTags] threadTagNamed:@"icon23-banme"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BanParsedInfo *ban = self.bans[indexPath.row];
    if (!ban.postID) return;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"awful://posts/%@", ban.postID]];
    [[UIApplication sharedApplication] openURL:url];
}

@end
