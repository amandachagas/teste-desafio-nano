module Api::V1::Concerns
  module ImportableFromCsvController
    extend ActiveSupport::Concern

    STORAGE_DIR = 'storage/uploads/csv'.freeze

    def import_csv
      file = params.require(:file)
      file_name = File.basename(file.path)
      storage_path = "#{STORAGE_DIR}/#{file_name}"
      FileUtils.cp(file.path, storage_path)

      args = { storage_path: storage_path }
      DeputiesImportation.call(args)
    end
  end
end
