# frozen_string_literal: true

class PlaceService
  def self.fetch_place(id)
    raw_place = JSON.parse(Faraday.get("https://storage.googleapis.com/coding-session-rest-api/#{id}").body)

    JSON.generate({
                    id: id,
                    name: raw_place['addresses'][0]['business']['identities'][0]['name'],
                    address: deserialize_address(raw_place),
                    opening_hours: deserialize_opening_hours(raw_place)
                  })
  end

  def self.deserialize_address(raw_place)
    address_lines = raw_place['addresses'][0]['where']
    "#{address_lines['street']} #{address_lines['house_number']}, #{address_lines['zipcode']} #{address_lines['city']}"
  end

  def self.deserialize_opening_hours(raw_place)
    weekly_hours = raw_place['opening_hours']['days']
    I18n.t('date.day_names').map do |day|
      {
        day: day,
        open_during: weekly_hours.fetch(day.downcase, []).map { |duration| "#{duration['start']} - #{duration['end']}" }
      }
    end
  end
end
