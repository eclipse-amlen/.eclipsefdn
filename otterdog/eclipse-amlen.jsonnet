local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('iot.amlen', 'eclipse-amlen') {
  settings+: {
    description: "",
    name: "Eclipse Amlen project",
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
      default_workflow_permissions: "read",
    },
  },
  teams+: [
  ],
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/amlen/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  _repositories+:: [
    orgs.newRepo('amlen') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "go",
        "javascript",
        "javascript-typescript",
        "python",
        "ruby",
        "typescript"
      ],
      code_scanning_default_setup_enabled: true,
      delete_branch_on_merge: false,
      description: "Message Broker for IoT/Mobile/Web. Mainly uses MQTT v3.x and v5. Aims to be easy to use, scalable and reliable",
      homepage: "",
      topics+: [
        "hacktoberfest",
        "iot",
        "mqtt",
        "mqtt-server"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: 1,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
        orgs.newBranchProtectionRule('1.0.0*') {
          required_approving_review_count: 1,
          requires_status_checks: false,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('amlen-website') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}