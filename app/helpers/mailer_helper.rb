module MailerHelper
  def self.send_mail_to_user(user, subject, partial_name, password)
    Mailer.generic_message(
      to: user.email,
      subject: subject,
      body: {
        user: user,
        password: password,
        first_name: ApplicationHelper.get_user_first_name(user),
        partial_name: partial_name
      }
    )
  end

  def self.send_mail_to_all_super_users(super_user, user, subject)
    Mailer.request_user_message(
      to: super_user.email,
      subject: subject,
      body: {
        super_user: super_user,
        user: user,
        first_name: ApplicationHelper.get_user_first_name(super_user)
      }
    )
  end

  def self.send_mail_for_conference_user(user, subject, partial_name, password, conference_variable)
    Mailer.generic_message(
      to: user.email,
      subject: subject,
      body: {
        user: user,
        password: password,
        first_name: ApplicationHelper.get_user_first_name(user),
        partial_name: partial_name,
        conference_variable: conference_variable
      }
    )
  end

  def self.send_mail_to_assigned_reviewers(reviewer, participant, mapping,subject_suffix,partial_name,email_content)
    Mailer.sync_message(
      {
        :to => reviewer.email,
        subject: "Assignment '#{participant.assignment.name}:'"+subject_suffix,
        cc: participant.assignment.instructor.email,
        :body => {
          :obj_name => participant.assignment.name,
          :link => "https://expertiza.ncsu.edu/response/new?id=#{mapping.id}",
          :type => 'submission',
          :first_name => ApplicationHelper.get_user_first_name(reviewer),
          :partial_name => partial_name,
          :team_name => participant.team,
          :body_text => email_content
        }
      }
    )
  end

   def self.send_mail_to_author(subject,body,email)
    @email = Mailer.author_mail(subject, body, email)
    @email.deliver_now
  end
end
