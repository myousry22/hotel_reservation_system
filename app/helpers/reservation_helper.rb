module ReservationHelper
    def format_date(date)
        parsed_date = Date.parse(date)
        parsed_date.strftime('%Y-%m-%d')
    end
end