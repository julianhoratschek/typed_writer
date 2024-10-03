# frozen_string_literal: true


typed_writer.always_ignore << %w[selbst]

player(
  internal_id: 'detective',

  names: %w[detektiv dich mich],

  actions: {
    examine: {
      names: %w[schau inspizier examiniere guck],
      ignore: %w[an],
      action: proc {
        that.in_inventory.examine ||
        that.here.examine ||
        "Ich kann #{that} hier nicht sehen"
      }
    },

    talk: {
      names: %w[sprich interrogier rede],
      ignore: %w[mit],
      action: proc {
        that.here.talk ||
        "Ich kann mit #{that} nicht sprechen"
      }
    },

    take: {
      names: %w[nimm steck],
      ignore: %w[ein mit],
      action: proc {
        obj = that.here
        case inventory << obj
        when Inventory.NOT_HERE then "Ich kann #{that} hier nicht finden"
        when Inventory.FULL then 'Mehr kann ich nicht mitnehmen'
        when Inventory.DUPLICATE then "Ich habe #{that} schon"
        when Inventory.ADDED then obj.taken
        end
      },

      use: {
        names: %w[benutze kombiniere verwende],
        ignore: %w[zusammen],
        split: %w[mit],
        action: proc {
          that.here + recipient.here ||
          that.in_inventory + recipient.here ||
          that.here + recipient.in_inventory ||
          that.in_inventory + recipient.in_inventory ||
          "Ich kann #{that} nicht mit #{recipient} benutzen"
        }
      },

      walk: {
        names: %w[geh beweg lauf],
        ignore: %w[zu nach auf zu hin],
        action: proc {
          move_to(that.here) ||
          "Ich kann nicht zu #{that} gehen"
        }
      }
    }
  }
)
