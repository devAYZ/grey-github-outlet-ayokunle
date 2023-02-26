//
//  Item.swift
//  grey-github-outlet-ayokunle
//
//  Created by Ayokunle Pro on 2/25/23.
//

import Foundation

// MARK: Item
struct Item: Identifiable, Codable {
    var id: Int?
    var nodeID, name, fullName: String?
    var owner: Owner?
    var itemPrivate, fork: Bool?
    var htmlURL, description, url: String?
    var createdAt, updatedAt, pushedAt: String?
    var size, stargazersCount, watchersCount, forksCount, openIssuesCount: Int?
    var homepage, language, masterBranch, defaultBranch: String?
    var score: Int?
    var archiveURL, assigneesURL, blobsURL, branchesURL: String?
    var collaboratorsURL, commentsURL, commitsURL, compareURL, contentsURL: String?
    var contributorsURL, deploymentsURL, downloadsURL, eventsURL, forksURL: String?
    var gitCommitsURL, gitRefsURL, gitTagsURL, gitURL: String?
    var issueCommentURL, issueEventsURL, issuesURL, keysURL, labelsURL: String?
    var languagesURL, mergesURL, milestonesURL, notificationsURL: String?
    var pullsURL, releasesURL, sshURL, stargazersURL, statusesURL: String?
    var subscribersURL, subscriptionURL, tagsURL, teamsURL: String?
    var treesURL, cloneURL, mirrorURL, hooksURL, svnURL: String?
    var forks, openIssues, watchers: Int?
    var hasIssues, hasProjects, hasPages, hasWiki: Bool?
    var hasDownloads, archived, disabled: Bool?
    var visibility: String?
    var license: License?
    
    var login: String?
    var avatarURL: String?
    var gravatarID: String?
    var followersURL: String?
    var followingURL: String?
    var gistsURL: String?
    var starredURL: String?
    var subscriptionsURL: String?
    var organizationsURL: String?
    var reposURL: String?
    var receivedEventsURL: String?
    var type: String?
    var siteAdmin: Bool?
    
    var topics: [String?]?
    var location: String?
    var bio: String?
    var publicRepos: Int?
    var followers, following: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case itemPrivate = "private"
        case htmlURL = "html_url"
        case description, fork, url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case masterBranch = "master_branch"
        case defaultBranch = "default_branch"
        case score
        case archiveURL = "archive_url"
        case assigneesURL = "assignees_url"
        case blobsURL = "blobs_url"
        case branchesURL = "branches_url"
        case collaboratorsURL = "collaborators_url"
        case commentsURL = "comments_url"
        case commitsURL = "commits_url"
        case compareURL = "compare_url"
        case contentsURL = "contents_url"
        case contributorsURL = "contributors_url"
        case deploymentsURL = "deployments_url"
        case downloadsURL = "downloads_url"
        case eventsURL = "events_url"
        case forksURL = "forks_url"
        case gitCommitsURL = "git_commits_url"
        case gitRefsURL = "git_refs_url"
        case gitTagsURL = "git_tags_url"
        case gitURL = "git_url"
        case issueCommentURL = "issue_comment_url"
        case issueEventsURL = "issue_events_url"
        case issuesURL = "issues_url"
        case keysURL = "keys_url"
        case labelsURL = "labels_url"
        case languagesURL = "languages_url"
        case mergesURL = "merges_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case pullsURL = "pulls_url"
        case releasesURL = "releases_url"
        case sshURL = "ssh_url"
        case stargazersURL = "stargazers_url"
        case statusesURL = "statuses_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case tagsURL = "tags_url"
        case teamsURL = "teams_url"
        case treesURL = "trees_url"
        case cloneURL = "clone_url"
        case mirrorURL = "mirror_url"
        case hooksURL = "hooks_url"
        case svnURL = "svn_url"
        case forks
        case openIssues = "open_issues"
        case watchers
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasPages = "has_pages"
        case hasWiki = "has_wiki"
        case hasDownloads = "has_downloads"
        case archived, disabled, visibility, license
        
        case login
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        
        case topics
        case location
        case bio
        case publicRepos = "public_repos"
        case followers, following
    }
}

// MARK: License
struct License: Codable {
    var key, name, url: String?
    var spdxID, nodeID, htmlURL: String?

    enum CodingKeys: String, CodingKey {
        case key, name, url
        case spdxID = "spdx_id"
        case nodeID = "node_id"
        case htmlURL = "html_url"
    }
}

// MARK: Owner
struct Owner: Codable {
    var login: String?
    var id: Int?
    var nodeID, avatarURL, gravatarID, url, receivedEventsURL, type: String?
    var htmlURL, followersURL, followingURL, gistsURL, starredURL: String?
    var subscriptionsURL, organizationsURL, reposURL, eventsURL: String?
    var siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case receivedEventsURL = "received_events_url"
        case type
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case siteAdmin = "site_admin"
    }
}
