class ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, record)
      raise Pundit::NotAuthorizedError.new('must be logged in') unless user

      @user = user
      @record = record
    end


end